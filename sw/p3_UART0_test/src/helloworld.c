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
#define SEND_TIMEOUT 1000
#define RECV_TIMEOUT 1000

int uart0_sendBuffer(XUartPs *InstancePtr, u8 *data, size_t num_bytes);
int uart0_recvBuffer(XUartPs *InstancePtr, u8 *buffer, size_t num_bytes);

int main()
{
	int status;
    XUartPs_Config *Config;

    init_platform();
    xil_printf("Ready to Start Uart crap\n");
    /*
	 * Initialize the UART driver so that it's ready to use
	 * Look up the configuration in the config table and then initialize it.
	 */
	Config = XUartPs_LookupConfig(XPAR_PS7_UART_0_DEVICE_ID);
	if (NULL == Config) {
		return XST_FAILURE;
	}
	xil_printf("Look up Config Success\n");

	status = XUartPs_CfgInitialize(&uart0, Config, Config->BaseAddress);
	if (status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	xil_printf("Initialize Config Success\n");

	char * string = "Hello, World!";
	size_t string_len = strlen(string);

	u8 recv_buffer[256];

	int bytes_sent = uart0_sendBuffer(&uart0, (u8*)string, string_len +1);
	xil_printf("Sent %d bytes...\n", bytes_sent);

	int bytes_recv = uart0_recvBuffer(&uart0, recv_buffer, string_len +1);
	xil_printf("Received %d bytes..\n", bytes_recv);

	sleep(3);
	xil_printf("Message received = '");
	size_t i;
	for (i = 0; i < bytes_recv -1; ++i) {
		xil_printf("%c", recv_buffer[i]);
	}
	xil_printf("'\n");
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

	while(bytes_recv < num_bytes) {
		buffer[bytes_recv] =  XUartPs_RecvByte(InstancePtr->Config.BaseAddress);
		bytes_recv++;
	}

	return bytes_recv;
}
