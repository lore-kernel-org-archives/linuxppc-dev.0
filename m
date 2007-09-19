Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7B2DDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 05:06:08 +1000 (EST)
Subject: Re: Problem booting linux with device tree table
From: Jon Loeliger <jdl@freescale.com>
To: Bartlomiej Sieka <tur@semihalf.com>
In-Reply-To: <46EF8715.4030707@semihalf.com>
References: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
	<46EF8715.4030707@semihalf.com>
Content-Type: text/plain
Message-Id: <1190228750.24204.6.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 19 Sep 2007 14:05:50 -0500
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

On Tue, 2007-09-18 at 03:06, Bartlomiej Sieka wrote:

> The following switches to dtc taken from
> http://www.denx.de/wiki/UBoot/UBootFdtInfo work for me:
> 
> dtc -b 0 -V 17 -R 4 -S 0x3000 -I dts -O dtb -f tqm5200.dts > tqm5200.dtb

-V 17 is the current default, btw.

jdl
