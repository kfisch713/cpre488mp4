/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <xuartps.h>
#include <xuartps_hw.h>

#include "platform.h"

XUartPs uart0;		/* The instance of the UART Driver */

int uart0_sendBuffer(XUartPs *InstancePtr, u8 *data, size_t num_bytes);
int uart0_recvBuffer(XUartPs *InstancePtr, u8 *buffer, size_t num_bytes);
int init_quad_cities(XUartPs_Config *Config);


int main()
{
    init_platform();
    XUartPs_Config config;
    u8 recv_buffer[256];
    char command[128];
    memset(recv_buffer, 0, sizeof(recv_buffer));

    if (init_quad_cities(&config)) {
    	return 1;
    }

    /*
    //send static commands
    strcpy(command, "$$$");
    uart0_sendBuffer(&uart0, (u8*)command, strlen(command));

    sleep(3);

    strcpy(command, "---\r");
    uart0_sendBuffer(&uart0, (u8*)command, strlen(command));
    uart0_recvBuffer(&uart0, recv_buffer, 64);

    xil_printf("%s", recv_buffer);
	*/


    //user inputs commands
    while(strcmp((char*)recv_buffer, "END")){
    	xil_printf("\r\n>>>");
    	scanf("%s", command);
    	xil_printf("\r\necho: %s", command);

    	if(strcmp(command, "---") == 0){
    		strcpy(command, "---\r");
    	}

    	uart0_sendBuffer(&uart0, (u8*)command, strlen(command));
    	sleep(1);
    	uart0_recvBuffer(&uart0, recv_buffer, 64);
    	xil_printf("\r%s", recv_buffer);
    }

    return 0;
}

/**
 * @param *Config: sets up a blank config and applies the config to UART0.
 * 					 Make the config in main.
 */
int init_quad_cities(XUartPs_Config *Config){
	int status;

	xil_printf("Ready to Start Uart crap\n");
	/*
	 * Initialize the UART driver so that it's ready to use
	 * Look up the configuration in the config table and then initialize it.
	 */
	Config = XUartPs_LookupConfig(XPAR_PS7_UART_0_DEVICE_ID);
	if (Config == NULL) {
		return XST_FAILURE;
	}
	xil_printf("Look up Config Success\n");

	status = XUartPs_CfgInitialize(&uart0, Config, Config->BaseAddress);
	if (status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XUartPs_SetBaudRate(&uart0, 115200);

	xil_printf("Initialize Config Success\n");
	return 0;
}

/*
 * Send a buffer one byte at a time. With a timeout specified by SEND_TIMEOUT.
 *
 * returns number of bytes sent
 */
int uart0_sendBuffer(XUartPs *InstancePtr, u8 *data, size_t num_bytes) {
	int bytes_sent = 0;


	while(bytes_sent < num_bytes) {
		XUartPs_SendByte(InstancePtr->Config.BaseAddress, data[bytes_sent]);
		//XUartPs_WriteReg(InstancePtr->Config.BaseAddress, XUARTPS_FIFO_OFFSET, data[bytes_sent]);
		bytes_sent++;
	}

	return bytes_sent;
}

/*
 * Recv a buffer one byte at a time. With a timeout specified by SEND_TIMEOUT.
 *
 * returns number of bytes received
 */
int uart0_recvBuffer(XUartPs *InstancePtr, u8 *buffer, size_t num_bytes) {
	int bytes_recv = 0;
	int iterations = 0;
	int found_data = 0;

	memset(buffer, 0, num_bytes);

	/*
	 * Two stages:
	 * 1) Wait for first piece of data. Could be different waiting period than stage 2.
	 * 2) Data should be coming in now. While it is coming in, read it character by character
	 * 	  and save it into a larger buffer (the one we pass in). When we havent seen any new
	 * 	  data for a long time, consider that the end of the data and return from function.
	 *
	 */
	iterations = 0;
	while(iterations < 50000){
		if(XUartPs_IsReceiveData(InstancePtr->Config.BaseAddress)){
			found_data = 1;
			xil_printf("found first data");
			break;
		}
		iterations++;
	}

	iterations = 0;
	if(found_data){
		while(iterations < 50000 ){
			if(XUartPs_IsReceiveData(InstancePtr->Config.BaseAddress)){
				xil_printf("found second data\r");
				buffer[bytes_recv] = XUartPs_RecvByte(InstancePtr->Config.BaseAddress);
				iterations = 0;
				bytes_recv++;
			}

			iterations++;
		}
	}




	/*
	 * Old way.
	 */
	/*
	while(iterations < 50000  && bytes_recv < num_bytes) {
		//xil_printf("iterations: %d\n", iterations);
		//buffer[bytes_recv] =  XUartPs_RecvByte(InstancePtr->Config.BaseAddress); //Dont use because it blocks
		buffer[bytes_recv] = XUartPs_ReadReg(InstancePtr->Config.BaseAddress, XUARTPS_FIFO_OFFSET);
		if(buffer[bytes_recv] != NULL) {
			bytes_recv++;
		}
		iterations++;
	}


	return ++bytes_recv;
	*/

	return bytes_recv;
}
