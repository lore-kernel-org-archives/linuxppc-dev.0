Message-ID: <187f01c10315$46329080$3000a8c0@primag>
From: "Mark Powell" <medp@primagraphics.co.uk>
To: "ibm405gp" <ibm405.linux@laposte.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <B25E2E5A003CD311B61E00902778AF2A02637685@SERVER1> <3B409EE3.9CFCD22B@laposte.net> <3B409FE6.783C46A6@mvista.com>
Subject: Re: ?Loading and debugging a linux kernel on a walnut board with a  BDI2000
Date: Mon, 2 Jul 2001 17:37:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ah yes, that's right - Scott reminded me. The vmlinuz-walnut file is in the
image format for the IBM Treeboot mechanism.

When I moved to PPCBoot for the boot ROM (http://ppcboot.sourceforge.net) I
had make a PPCboot image from the plain kernel image, which is in
    arch/ppc/boot/images/vmlinux.gz

You might tree using this file with the BDI2000.

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


----- Original Message -----
From: "Scott Anderson" <scott_anderson@mvista.com>
To: "ibm405gp" <ibm405.linux@laposte.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, July 02, 2001 5:23 PM
Subject: Re: ?Loading and debugging a linux kernel on a walnut board with a
BDI2000



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
