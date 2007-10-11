Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E808DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 02:23:52 +1000 (EST)
Message-ID: <470E4DFF.2050800@scram.de>
Date: Thu, 11 Oct 2007 18:23:27 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: keng_629 <keng_629@126.com>
Subject: Re: mpc860T linux2.6.23 boot problem
References: <200710112331564685179@126.com>
In-Reply-To: <200710112331564685179@126.com>
Content-Type: text/plain; charset=GB2312
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi keng_629,
> i have ported linux2.6.23 to mpc860t board use cpm smc1 as serial port.
> when i boot my kernel with ramdisk i find it stop after print"Loading
> Ramdisk to 07e20000, end 07fa4100 ... OK"
Could you try the patches from git://git.bocc.de/dbox2.git ppc-fixes i
submitted recently?
You might as well download the series (the patches starting with
PATCH#2) from
http://patchwork.ozlabs.org/linuxppc-embedded/list?person=1023

Thanks,
Jochen
