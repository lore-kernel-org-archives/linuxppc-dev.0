Message-ID: <20020601053540.73803.qmail@web15005.mail.bjs.yahoo.com>
Date: Sat, 1 Jun 2002 13:35:40 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: Can usb and SMC2(uart) work together?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All:
 I find in uart.c ,
 static struct serial_state rs_table[] = {
         /* UART CLK   PORT          IRQ      FLAGS
 NUM   */
 #ifndef CONFIG_SCC3_ENET        /* SMC1 not usable
 with Ethernet on SCC3 */
         { 0,     0, PROFF_SMC1, CPMVEC_SMC1,   0,
 0
 },    /* SMC1 ttyS0 */
#endif
#if !defined(CONFIG_USB_MPC8xx) &&
 !defined(CONFIG_USB_CLIENT_MPC8xx)
 #ifdef CONFIG_SMC2_UART
         { 0,     0, PROFF_SMC2, CPMVEC_SMC2,   0,
 1
 },    /* SMC2 ttyS1 */
 #endif
 #endif  /* CONFIG_USB_xxx */

 #ifdef CONFIG_SCC1_UART
         { 0,     0, PROFF_SCC1, CPMVEC_SCC1,   0,
 (NUM_IS_SCC | 0) },    /* SCC2 ttyS2 */
 #endif
 #ifdef CONFIG_SCC2_UART
         { 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,
 (NUM_IS_SCC | 1) },    /* SCC2 ttyS2 */
 #endif
 ....

 Does this mean usb and smc2 can't work together?Why?

 Thx
 --zhouchang



2002年世界杯群雄鏖战 雅虎中国聚焦日韩
http://cn.fifaworldcup.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
