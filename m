Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id D158567A6B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 00:53:39 +1000 (EST)
Received: from [10.1.1.138] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 10 Apr 2005 10:53:37 -0400
Date: Sun, 10 Apr 2005 10:51:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0504101046030.8150@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: how to get busybox shell prompt on console port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  i'm still wrestling with how to get my 8xx-based board's shell
prompt to show up on the console port.  i've built a simple
2.6.11.7-based kernel and (busybox-based) root filesystem and, fairly
quickly, i realized i needed to use the following kernel boot line:

    Linux/PPC load: rw root=/dev/ram0 console=ttyCPM0,9600

  as the boot proceeds, i eventually see:

  Serial: CPM driver $Revision: 0.01 $
  ttyCPM0 at MMIO 0xfa200a80 (irq = 20) is a CPM UART
  ttyCPM1 at MMIO 0xfa200a00 (irq = 46) is a CPM UART

which seems to be a good sign.  however, after all the standard boot
output, i'm left with no shell prompt, and i'm assuming it's just
because i haven't correctly started the shell thru /etc/inittab with
the correct parameters to have it talk to that console port.

  what would be the correct invocation of /bin/sh in /etc/inittab to
reflect my serial/console port setup above?  thanks.

rday
