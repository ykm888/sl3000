/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (c) 2021 MediaTek Inc.
 *
 * Device Tree binding constants for MediaTek MT7981 reset controller
 */

#ifndef _DT_BINDINGS_RESET_MT7981_H
#define _DT_BINDINGS_RESET_MT7981_H

#define MT7981_TOPRGU_CONSYS_RST    0
#define MT7981_TOPRGU_ETH_RST       1
#define MT7981_TOPRGU_PCIE_RST      2
#define MT7981_TOPRGU_USB_RST       3
#define MT7981_TOPRGU_WOCPU_RST     4
#define MT7981_TOPRGU_SGMII_RST     5
#define MT7981_TOPRGU_XPON_RST      6
#define MT7981_TOPRGU_FE_RST        7
#define MT7981_TOPRGU_SW_RST        8

#define MT7981_RST_NR               9

#endif /* _DT_BINDINGS_RESET_MT7981_H */
