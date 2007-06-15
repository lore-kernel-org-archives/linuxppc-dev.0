Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2BE28DDF92
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:19:10 +1000 (EST)
Date: Fri, 15 Jun 2007 14:19:17 -0700 (PDT)
Message-Id: <20070615.141917.85409547.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070615171545.316dfac7@the-village.bc.nu>
References: <1181918159.25228.543.camel@pmac.infradead.org>
	<Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
	<20070615171545.316dfac7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: axboe@kernel.dk, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 15 Jun 2007 17:15:45 +0100

> > > Any particular reason why this is done as a separate block device driver
> > > rather than as SCSI?
> > 
> > Because no new fake SCSI drivers are accepted anymore.
> 
> Where did drivers/ata come from ;)
> 
> How about making it a fake ata driver if James is being fussy 8)

That sounds like a good idea for my virtual I/O case on
Niagara too actually :-)

Another quirk I have to deal with is that under LDOMs you
can export full disks and also just slices.  So I'll have
to get down into the partition machinery to support that
somehow.
