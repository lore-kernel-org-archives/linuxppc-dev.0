Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC36BDDE3B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 18:32:31 +1000 (EST)
Date: Tue, 10 Jul 2007 10:32:41 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/6] PS3 Storage Drivers for 2.6.23, take 4
Message-ID: <20070710083241.GV13902@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
	<20070710075506.GS13902@kernel.dk>
	<18067.15564.241168.217875@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18067.15564.241168.217875@cargo.ozlabs.ibm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@vision.unipv.it>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10 2007, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > I have no objections to the block bits, however I feel uneasy merging
> > the full patchset unless patch #1 has been acked by the platform person.
> 
> I have the first 3 patches in my queue, so yes I've acked it.  It's
> probably easiest if the remaining 3 go through my queue once they've
> been acked - or if you prefer, you can push #4 via your tree once I've
> got Linus to pull my tree.  Let me know either way.

If you already have the 3 first patches, just slurp up the rest as well.
No point in making it more complicated than we have to.

-- 
Jens Axboe
