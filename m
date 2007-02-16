Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 81DD6DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:46:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so146586ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 06:45:58 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD
	drives
Date: Fri, 16 Feb 2007 15:51:49 +0100
References: <20070210203512.GA25586@aepfle.de>
	<20070216092046.GA2572@aepfle.de>
	<200702161546.01159.bzolnier@gmail.com>
In-Reply-To: <200702161546.01159.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702161551.49697.bzolnier@gmail.com>
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


On Friday 16 February 2007 15:46, Bartlomiej Zolnierkiewicz wrote:
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

s/pata_winbond/pata_sl82c105/ of course
