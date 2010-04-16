Return-Path: <nm127@freemail.hu>
Received: from relay03.digicable.hu (relay03.digicable.hu [92.249.128.185])
	by ozlabs.org (Postfix) with ESMTP id BA1A3B7D63
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Apr 2010 01:44:04 +1000 (EST)
Message-ID: <4BC885C0.5000509@freemail.hu>
Date: Fri, 16 Apr 2010 17:44:00 +0200
From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
MIME-Version: 1.0
To: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>
Subject: serial driver for MPC5554?
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

is there somebody working on the MPC5554 [1] serial port driver? I could
only find linux/drivers/serial/mpc52xx_uart.c but I'm not sure whether
this could work together with the eSCI on-chip hardware module which
can be found in MPC5554 [2].

References:
[1] Freescale MPC5554
    http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5554

[2] MPC5553/MPC5554 Microcontroller Reference Manual
    http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf

Regards,

	Márton Németh
