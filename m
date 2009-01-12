Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id BF390DE0DC
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 04:30:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
Date: Mon, 12 Jan 2009 18:29:57 +0100
References: <1231601482-28123-1-git-send-email-adrian@lisas.de>
	<20090110195040.GA19945@lisas.de> <496B784C.5010800@gefanuc.com>
In-Reply-To: <496B784C.5010800@gefanuc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901121829.58489.arnd@arndb.de>
Cc: Martyn Welch <martyn.welch@gefanuc.com>, Murali N Iyer <mniyer@us.ibm.com>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 12 January 2009, Martyn Welch wrote:
> Adrian Reber wrote:
> > The reason why I did not use mtd is that part of the flash is used by
> > the firmware image and I do not know if that works with mtd, if only a
> > part of the flash can be used. SLOF does also a "CRC" check over the
> > firmware image, so that image must have valid SLOF "CRC". The flash is
> > a direct mapped flash, but the size of the firmware can vary.
>
> It can. MTD can create "partitions" within the flash, for an example
> see lines 84-110 of arch/powerpc/bootdts/sbc8641d.dts (http://tinyurl.com/7k2kym) 
> 
> Partitions can also be labeled as read-only, I guess the CRC could be
> checked from userspace as necessary. 

Murali has also done a modified firmware for experiments in the past where
he added the device tree entry for the flash on a PxCAB. As I recall, he did
not see any problems with that.

	Arnd <><
