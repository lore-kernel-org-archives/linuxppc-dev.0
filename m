Return-Path: <SRS0=0yox=RM=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8DB4BDDE35
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 06:56:45 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] PowerPC: update 440EP(x)/440GR(x) identical PVR issue
	workaround
Date: Fri, 21 Dec 2007 20:56:41 +0100
References: <20071221160723.GA1430@ru.mvista.com>
	<20071221104347.54cd2ad5@zod.rchland.ibm.com>
	<476C1862.8080603@ru.mvista.com>
In-Reply-To: <476C1862.8080603@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712212056.41798.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Valentine,

On Friday 21 December 2007, Valentine Barshak wrote:
> > Good catch.  I'll have to look more closely to see if anything else
> > would be broken by changing the cpu node name from "PowerPC,xxxx@0" to
> > "cpu@0".
> >
> > josh
>
> Looks like we need a u-boot update for 405Ex Kilauea board.
> Mine (U-Boot 1.3.0-rc3-gccc2fe86-dirty (Oct 25 2007 - 12:18:41))
> fails to boot with new cpu node changes:
>
>     Uncompressing Kernel Image ... OK
>     Booting using the fdt at 0x400000
> le to update property /cpus/PowerPC,405EX@0:timebase-frequency,
> err=FDT_ERR_NOTFOUND
> Unable to update property /cpus/PowerPC,405EX@0:clock-frequency,
> err=FDT_ERR_NOTFOUND

Already done. :) Please take a look at the current implementation in the 
for-1.3.2 branch of the u-boot-ppc4xx custodian repo:

http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot/u-boot-ppc4xx.git;a=shortlog;h=for-1.3.2

This works for both cpu node names.

Best regards,
Stefan
