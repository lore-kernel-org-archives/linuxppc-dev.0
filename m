Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 19F7EDDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:03:22 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so151053ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:03:20 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD
	drives
Date: Fri, 16 Feb 2007 16:09:07 +0100
References: <20070210203512.GA25586@aepfle.de>
	<200702161553.54550.bzolnier@gmail.com>
	<45D5C5CC.9070406@ru.mvista.com>
In-Reply-To: <45D5C5CC.9070406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702161609.07899.bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Friday 16 February 2007 15:55, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
> >>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
> >>pata_sl82c105 (indeed better version of sl82c105 driver).
> 
> > I was under the impression that with your fixes these drivers
> > (sl82c105 and pata_sl82c105) are functionally equivalent.
> 
>     They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
> sl82c105 still supports only MWDMA2.

Indeed and it seems that IDE core needs ->dma_mode to fix this.

Thanks,
Bart
