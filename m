Message-ID: <3CE2481B.5070108@elsoft.ch>
Date: Wed, 15 May 2002 13:35:55 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
Content-Type: multipart/mixed;
 boundary="------------030608090909010102090904"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------030608090909010102090904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello


The attached patch fixes the following issues:

    - arch/ppc/kernel/ocp.c
       wrong comment and export of ocp_get_max() for module support.

    - arch/ppc/kernel/ocp_proc.c
       compiler warnings fixed in various seq_printf().
       i don't know if this also works correctly on PPC440
       with its 36-bit phys_addr_t?

    - arch/ppc/kernel/ocp_uart.c
       various fixes to opc_uart_init().
       initialize curr_uart, free previously allocated driver
       object and fix return value.

    - arch/ppc/kernel/ppc4xx_setup
       missing early_uart_init() prototype.

    - drivers/char/ibm_ocp_gpio.c
       stop modprobe complaining about tainted kernel ("GPL license").
       initialize curr_gpio and fix return value.

    - drivers/i2c/i2c-adap-ibm_ocp.c
       fixed call to ocp_get_max().
       initialize curr_iic.
       remove module parameters "base" and "irq".

    - drivers/i2c/i2c-algo-ibm_ocp.c
       remove module paramter "iic_test".


Dave



--------------030608090909010102090904
Content-Type: application/octet-stream;
 name="patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch.bz2"

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
l/wKIW+unINmkAyQ0NMa/8XckU4UJB4c6kVA
--------------030608090909010102090904--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
