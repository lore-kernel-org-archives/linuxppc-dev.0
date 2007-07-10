Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1BFCDDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 18:15:11 +1000 (EST)
Date: Tue, 10 Jul 2007 09:55:06 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 0/6] PS3 Storage Drivers for 2.6.23, take 4
Message-ID: <20070710075506.GS13902@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10 2007, Geert Uytterhoeven wrote:
> On Wed, 4 Jul 2007, Geert Uytterhoeven wrote:
> > This is the fourth submission of the new PS3 storage drivers:
> >   [1] ps3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
> >   [2] ps3: Storage Driver Core
> >   [3] ps3: Storage device registration routines.
> >   [4] ps3: Disk Storage Driver
> >   [5] ps3: BD/DVD/CD-ROM Storage Driver
> >   [6] ps3: FLASH ROM Storage Driver
> > 
> > They are based on:
> >   - the current Linux kernel source tree,
> >   - plus the PS3 patches already submitted by Geoff Levand on linuxppc-dev,
> >   - plus the shost_priv() patch in scsi-misc (commit
> >     bcd92c9fbcc679ee95003083056f0441a1f474fa).
> > 
> > All issues raised during the previous review rounds should be fixed.
> > There were no more comments after the third submission.
> > 
> > Paul already integrated Geoff Levand's PS3 patches and the first 3 patches
> > in this series in the for-2.6.23 branch in powerpc.git.
> > 
> > Maintainers of block/SCSI/misc, can you please ack the last 3 patches so Paul
> > can take them, too?
> 
> Ping block/SCSI/misc maintainers?

I have no objections to the block bits, however I feel uneasy merging
the full patchset unless patch #1 has been acked by the platform person.

-- 
Jens Axboe
