Message-ID: <3B409FE6.783C46A6@mvista.com>
Date: Mon, 02 Jul 2001 16:23:02 +0000
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: ibm405gp <ibm405.linux@laposte.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ?Loading and debugging a linux kernel on a walnut board with a
 BDI2000
References: <B25E2E5A003CD311B61E00902778AF2A02637685@SERVER1> <3B409EE3.9CFCD22B@laposte.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ibm405gp wrote:
> My "vmlinuz-walnut" file generated with "make zImage" (with mvista
> toolschain) seems invalid for
> the bdi2000 but it works fine with 1.15 ROM Monitor

It's been a while since I played with it, but as I recall the makefile
tacks on a header to create an IBM Evaluation Board image.  To figure
out what it is doing, you might want to look in
arch/ppc/boot/tree/Makefile for something called mkevimg.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
