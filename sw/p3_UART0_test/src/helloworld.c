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
#include <xuartps.h>
#include <xuartps_hw.h>

#include "platform.h"

XUartPs Uart_Ps;		/* The instance of the UART Driver */

int sendString(XUartPs *, const char*);

int main()
{
//	int status;
//    XUartPs_Config *Config;

    init_platform();
    xil_printf("Ready to Start Uart crap\n");
    printf("REadyto Start Uart crap\n");
//    /*
//	 * Initialize the UART driver so that it's ready to use
//	 * Look up the configuration in the config table and then initialize it.
//	 */
//	Config = XUartPs_LookupConfig(XPAR_PS7_UART_0_DEVICE_ID);
//	if (NULL == Config) {
//		return XST_FAILURE;
//	}
//
//	xil_printf("Look up Config Success\n");
//
//
//	status = XUartPs_CfgInitialize(&Uart_Ps,Config, Config->BaseAddress);
//	if (status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	XUartPs_SetBaudRate(&Uart_Ps, 115200);

    return 0;
}


int sendString(XUartPs * uart_ps, const char* string) {
	return XUartPs_Send(uart_ps, (u8*)string, strlen(string));
}
