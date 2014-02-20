Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DAD462C0300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 07:53:18 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: multiple MSI interrupts on FSL-MPIC
Date: Thu, 20 Feb 2014 21:53:08 +0100
Message-Id: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds support for multiple MSI interrupts on FSL's MPIC. The
code has been tested on v3.2 with custom FPGA device on PCIe and then
forward ported. Patch #1 has been created from scratch during porting,
patch #2 almost applied as-it.

Sebastian
