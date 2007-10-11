Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2ADAADE07D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 05:14:23 +1000 (EST)
Message-ID: <470E7607.4070302@freescale.com>
Date: Thu, 11 Oct 2007 14:14:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: mpc860T linux2.6.23 boot problem
References: <200710112331564685179@126.com> <470E4DFF.2050800@scram.de>
In-Reply-To: <470E4DFF.2050800@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jochen Friedrich wrote:
> Hi keng_629,
>> i have ported linux2.6.23 to mpc860t board use cpm smc1 as serial port.
>> when i boot my kernel with ramdisk i find it stop after print"Loading
>> Ramdisk to 07e20000, end 07fa4100 ... OK"
> Could you try the patches from git://git.bocc.de/dbox2.git ppc-fixes i
> submitted recently?
> You might as well download the series (the patches starting with
> PATCH#2) from
> http://patchwork.ozlabs.org/linuxppc-embedded/list?person=1023

Or better yet, use paulus's git tree which has most of the above 
patches, as well as several other patches relevant to 8xx.  Note that 
there are some device tree changes you'll need to make -- look at the 
mpc885ads dts.

-Scott
