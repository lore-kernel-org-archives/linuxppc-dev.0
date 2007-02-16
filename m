Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A6C85DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 04:37:35 +1100 (EST)
Date: Fri, 16 Feb 2007 18:37:44 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD
	drives
Message-ID: <20070216173744.GA7520@aepfle.de>
References: <20070210203512.GA25586@aepfle.de> <45D4E82B.7020403@garzik.org>
	<20070216092046.GA2572@aepfle.de>
	<200702161546.01159.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200702161546.01159.bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackeras <paulus@samba.org>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 16, Bartlomiej Zolnierkiewicz wrote:

> 
> Hi,
> 
> On Friday 16 February 2007 10:20, Olaf Hering wrote:
> > 
> > Change the default for the built-in IDE on p610/p615/p630 from
> > ide to libata. libata has better error handling and the drive can
> > recover when hald does its CD media polling.
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> Does IDE sl82c105 need the same udelay() fix patch as done for
> pata_winbond?

I dont know, but I suspect a delay is required somewhere.
