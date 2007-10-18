Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id 7C5BEDDE3D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:19:20 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id r27so129453ele
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 15:19:18 -0700 (PDT)
Message-ID: <bfa0697f0710181519y261b41b1y46df293c61be344c@mail.gmail.com>
Date: Thu, 18 Oct 2007 16:19:17 -0600
From: "Alan Bennett" <alan@akb.net>
To: linuxppc-dev@ozlabs.org
Subject: driver using device trees, irqs, powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Need help adding new driver to supports a custom FPGA.  Is there a
good driver that anyone would recommend I can look at that is fully
functional, works with 2.6.23 (powerpc style) and is described within
a device tree?

Bonus points:
  uses freescale interrupts (timers/irq's from mpc 82xx/etc...)
  isn't enet / cpm_uart (I've already looked at these)

-Alan
