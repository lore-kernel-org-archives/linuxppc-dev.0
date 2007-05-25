Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 6945ADDE48
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 02:50:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Date: Fri, 25 May 2007 18:50:29 +0200
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
In-Reply-To: <20070525083632.677742000@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705251850.30342.arnd@arndb.de>
Cc: Geert.Uytterhoeven@sonycom.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 May 2007, Geert.Uytterhoeven@sonycom.com wrote:
> Add a CD/DVD/BD Storage Driver for the PS3:
>   - Implemented as a SCSI device driver

I assume you tried implementing it as a block device driver,
like you PS3 disk driver does, and failed for some reason.

What is the problem? Is there infrastructure missing in the
CD-ROM layer?

	Arnd <><
