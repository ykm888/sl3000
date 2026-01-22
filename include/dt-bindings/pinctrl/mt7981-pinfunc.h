/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (c) 2021 MediaTek Inc.
 *
 * Device Tree binding constants for MediaTek MT7981 pin functions
 */

#ifndef _DT_BINDINGS_PINFUNC_MT7981_H
#define _DT_BINDINGS_PINFUNC_MT7981_H

/* GPIO function definitions */
#define MT7981_PIN_GPIO             0
#define MT7981_PIN_UART0_TX         1
#define MT7981_PIN_UART0_RX         2
#define MT7981_PIN_UART1_TX         3
#define MT7981_PIN_UART1_RX         4
#define MT7981_PIN_SPI0_CLK         5
#define MT7981_PIN_SPI0_MOSI        6
#define MT7981_PIN_SPI0_MISO        7
#define MT7981_PIN_SPI0_CS          8
#define MT7981_PIN_I2C0_SCL         9
#define MT7981_PIN_I2C0_SDA         10
#define MT7981_PIN_PCIE_CLKREQ      11
#define MT7981_PIN_PCIE_WAKE        12
#define MT7981_PIN_PCIE_PERST       13
#define MT7981_PIN_SGMII_TX         14
#define MT7981_PIN_SGMII_RX         15
#define MT7981_PIN_XPON_TX          16
#define MT7981_PIN_XPON_RX          17

#define MT7981_PINFUNC_NR           18

#endif /* _DT_BINDINGS_PINFUNC_MT7981_H */
