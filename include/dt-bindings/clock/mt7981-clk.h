/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (c) 2021 MediaTek Inc.
 *
 * Device Tree binding constants for MediaTek MT7981 clocks
 */

#ifndef _DT_BINDINGS_CLOCK_MT7981_H
#define _DT_BINDINGS_CLOCK_MT7981_H

/* TOPCKGEN clocks */
#define CLK_TOP_CB_CKSQ_40M        0
#define CLK_TOP_CB_M_416M          1
#define CLK_TOP_CB_M_D2            2
#define CLK_TOP_CB_M_D3            3
#define CLK_TOP_CB_M_D4            4
#define CLK_TOP_CB_M_D8            5
#define CLK_TOP_CB_MM_720M         6
#define CLK_TOP_CB_MM_D2           7
#define CLK_TOP_CB_MM_D3           8
#define CLK_TOP_CB_MM_D4           9
#define CLK_TOP_CB_MM_D6           10
#define CLK_TOP_CB_MM_D8           11
#define CLK_TOP_CB_APLL2_196M      12
#define CLK_TOP_CB_APLL2_D2        13
#define CLK_TOP_CB_APLL2_D4        14
#define CLK_TOP_CB_NET1PLL_250M    15
#define CLK_TOP_CB_NET1PLL_D2      16
#define CLK_TOP_CB_NET1PLL_D4      17
#define CLK_TOP_CB_NET1PLL_D8      18
#define CLK_TOP_CB_NET2PLL_800M    19
#define CLK_TOP_CB_NET2PLL_D2      20
#define CLK_TOP_CB_NET2PLL_D4      21
#define CLK_TOP_CB_NET2PLL_D8      22
#define CLK_TOP_CB_WEDMCU_208M     23
#define CLK_TOP_CB_WEDMCU_D2       24
#define CLK_TOP_CB_WEDMCU_D4       25
#define CLK_TOP_CB_SGM_325M        26
#define CLK_TOP_CB_SGM_D2          27
#define CLK_TOP_CB_SGM_D4          28
#define CLK_TOP_CB_SGM_D8          29
#define CLK_TOP_CB_XTAL_40M        30

/* Peripheral clocks */
#define CLK_ETH_SW                 31
#define CLK_ETH_FE                 32
#define CLK_ETH_GP2                33
#define CLK_ETH_WOCPU              34
#define CLK_ETH_SGMII              35
#define CLK_ETH_XGPON              36
#define CLK_ETH_EPON               37
#define CLK_ETH_GEPON              38
#define CLK_ETH_XPON               39

/* Additional clocks */
#define CLK_WED                    40
#define CLK_WOCPU                  41
#define CLK_PCIE                   42
#define CLK_USB                    43
#define CLK_SGMII                  44
#define CLK_ETH                    45
#define CLK_TOP_AXI_SEL            46
#define CLK_TOP_MEM_SEL            47
#define CLK_TOP_MM_SEL             48
#define CLK_TOP_NETSYS_SEL         49
#define CLK_TOP_WEDMCU_SEL         50
#define CLK_TOP_SGM_SEL            51
#define CLK_TOP_XTAL_SEL           52

#define CLK_NR_CLK                 53

#endif /* _DT_BINDINGS_CLOCK_MT7981_H */
