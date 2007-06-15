Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A50D9DDEF4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 02:10:26 +1000 (EST)
Date: Fri, 15 Jun 2007 17:15:45 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
Message-ID: <20070615171545.316dfac7@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.352093000@pademelon.sonytel.be>
	<1181918159.25228.543.camel@pmac.infradead.org>
	<Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Any particular reason why this is done as a separate block device driver
> > rather than as SCSI?
> 
> Because no new fake SCSI drivers are accepted anymore.

Where did drivers/ata come from ;)

How about making it a fake ata driver if James is being fussy 8)
