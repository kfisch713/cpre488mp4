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

#define QUAD_NUM QUAD-1
#define QUAD 6

/* Bit shifting for endianness of 16-bit numbers */
#define LSByte16(x) ((x) & 0xff)
#define MSByte16(x) (((x) >> 8) & 0xff)
/* Build a 16-bit integer out of two bytes */
#define BytesTo16(lsb, msb) (((lsb) & 0xff) | (((msb) & 0xff) << 8))
/* Same for 32bit */
#define IntByte1(x) ((x) & 0xff)
#define IntByte2(x) (((x) >> 8) & 0xff)
#define IntByte3(x) (((x) >> 16) & 0xff)
#define IntByte4(x) (((x) >> 24) & 0xff)
#define BytesToInt(b1, b2, b3, b4) (((b1) & 0xff) | (((b2) << 8) & 0xff) \
		| (((b3) << 16) & 0xff) | (((b4) & 0xff)))


const char* QUAD_ADDRESSES[] = {
		"81EBB68B7913",
		"81EBB686E1D4",
		"81EBB681B36C",
		"81EBADE7A8CE",
		"81E99F00F1A3",
		"81EBADCD9A1E",
		"81EBB6906A6D"
};

#define MSP_SET_RAW_RC	200

enum MSP_BYTE {
	PREAMBLE,
	DIRECTION = 2,
	SIZE,
	COMMAND_ID,
	DATA_START,
};

//struct msp_packet {
//
//};

int uart0_sendBuffer(XUartPs *InstancePtr, u8 *data, size_t num_bytes);
int uart0_recvBuffer(XUartPs *InstancePtr, u8 *buffer, size_t num_bytes);
int init_quad_cities(XUartPs_Config *Config);
int send_command(XUartPs *InstancePtr, char* command, size_t command_len);

char test_quad[6] = {0x24, 0x4d, 0x3c, 0x00, 0x6c, 0x6c };
int main()
{
    init_platform();
    XUartPs_Config config;
    u8 recv_buffer[256];
    size_t recv_buf_len = sizeof(recv_buffer);
    char command[128];
    memset(recv_buffer, 0, recv_buf_len);

    if (init_quad_cities(&config)) {
    	return 1;
    }

//    sleep(1);
//    send_command(&uart0, "$$$", 3);
//    sleep(1);
//    send_command(&uart0, "SM,3", 4);
//    sleep(1);
//    send_command(&uart0, "SP,0000", 7);
//    sleep(1);
//    send_command(&uart0, "SR,Z", 4);
//    sleep(1);
//
//    strcpy(command, "SR,");
//    strcat(command, QUAD_ADDRESSES[QUAD_NUM]);
//
//    send_command(&uart0, command, strlen(command));
//    send_command(&uart0, "---", 3);
//
//    sleep(1);
//    send_command(&uart0, "test_quad", 9);

    //user inputs commands
    while (1) {
//    	xil_printf("\r\n>>>");
//    	scanf("%s", command);
//
//    	if (strcmp(command, "quit") == 0) {
//    		return 0;
//    	}
//
    	send_command(&uart0, "arm", strlen(command));

    	memset(command, 0, sizeof(command));
    }

    return 0;
}

int send_command(XUartPs * uart, char* command, size_t command_len) {
	size_t len;
	u8 send_buff[512];
	memset(send_buff, 0, sizeof(send_buff));
	u8 recv_buff[512];
	memset(recv_buff, 0, sizeof(recv_buff));
	static int binary = 0;

	if (strncmp(command, "data_mode", strlen("data_mode")) == 0) {
		binary = !binary;
		return 0;
	}

	if (strcmp(command, "test_quad") == 0) {
		memcpy(send_buff, test_quad, 6);
		len = 6;
	} else if (strncmp(command, "$$$", 3) == 0) {
		memcpy(send_buff, command, strlen(command));
		len = strlen(command);
	} else if (strncmp(command, "arm", 3) == 0) {
		static uint16_t roll_and_pitch = 1500;
		static uint16_t yaw = 1950;
		static uint16_t throttle = 1100;
		memcpy((char*)send_buff, "$M", 2);
		send_buff[DIRECTION] = '<';
		send_buff[SIZE] = 16;
		send_buff[COMMAND_ID] = MSP_SET_RAW_RC;
		send_buff[DATA_START] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+1] = MSByte16(roll_and_pitch);
		send_buff[DATA_START+2] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+3] = MSByte16(roll_and_pitch);
		send_buff[DATA_START+4] = LSByte16(yaw);
		send_buff[DATA_START+5] = MSByte16(yaw);
		send_buff[DATA_START+6] = LSByte16(throttle);
		send_buff[DATA_START+7] = MSByte16(throttle);
		send_buff[DATA_START+8] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+9] = MSByte16(roll_and_pitch);
		send_buff[DATA_START+10] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+11] = MSByte16(roll_and_pitch);
		send_buff[DATA_START+12] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+13] = MSByte16(roll_and_pitch);
		send_buff[DATA_START+14] = LSByte16(roll_and_pitch);
		send_buff[DATA_START+15] = MSByte16(roll_and_pitch);
		size_t i;
		uint8_t crc = 0;
		for (i = SIZE; i < (DATA_START + 16); ++i) {
			crc ^= send_buff[i];
		}
		send_buff[DATA_START + 16] = crc;
		len = DATA_START + 16;
	} else if (strncmp(command, "disarm", 6) == 0) {

	} else {
		strcpy((char*)send_buff, command);
		strcat((char*)send_buff, "\r");
		len = strlen((char*)send_buff);
		xil_printf("sending AT command : %d %s\n", len, send_buff);
	}

	uart0_sendBuffer(uart, send_buff, len);
	uart0_recvBuffer(uart, recv_buff, 512);

	if (strcmp(command, "test_quad") == 0) {
		int i;
		xil_printf("Quad response... \n");
		for (i = 0; i < 12; ++i) {
			xil_printf("0x%2X ", recv_buff[i]);
		}
		xil_printf("\n");
	} else if (strcmp(command, "arm") == 0) {
//		xil_printf("arming\n");
	} else  {
		xil_printf("%s\n", recv_buff);
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
	XUartPs_SetOptions(&uart0, XUARTPS_OPTION_RESET_RX);
	XUartPs_SetOptions(&uart0, XUARTPS_OPTION_RESET_TX);

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

//	/*
//	 * Wait until there is space in TX FIFO
//	 */
//	while (XUartPs_IsTransmitFull(InstancePtr->Config.BaseAddress));

	while (XUartPs_IsSending(InstancePtr));


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
	while(iterations < 2000000){
		if(XUartPs_IsReceiveData(InstancePtr->Config.BaseAddress)){
			found_data = 1;
			//xil_printf("found first data");
			break;
		}
		iterations++;
	}

	iterations = 0;
	if(found_data){
		while(iterations < 100000 ){
			if(bytes_recv > num_bytes)
				break;
			if(XUartPs_IsReceiveData(InstancePtr->Config.BaseAddress)){
				buffer[bytes_recv] = XUartPs_RecvByte(InstancePtr->Config.BaseAddress);
				iterations = 0;
				bytes_recv++;
			}

			iterations++;
		}
	}

	return bytes_recv;
}
