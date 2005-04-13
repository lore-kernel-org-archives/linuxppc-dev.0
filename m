Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 6230E67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 02:34:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 13 Apr 2005 18:33:59 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D44@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <scarayol@assystembrime.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: mmap : please help !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sophie CARAYOL wrote:
[...]
> What is the good manner to read or write in the physical memory?

Please have a look at Denx's FAQ for accessing memory bus:

=20
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
or shorter: http://tinyurl.com/6c7th

Depending on the O_SYNC flag passed to open, the mmap'ed memory will be
accessed through non guarded cache or not. See linux/drivers/char/mem.c.
The ppc instruction "eieio" deals with I/O ordering.


Kenavo
--=20
Stephane

PS: be careful not sending twice the same mail to the list=20
