Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18067.15564.241168.217875@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 18:01:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [patch 0/6] PS3 Storage Drivers for 2.6.23, take 4
In-Reply-To: <20070710075506.GS13902@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
	<20070710075506.GS13902@kernel.dk>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens Axboe writes:

> I have no objections to the block bits, however I feel uneasy merging
> the full patchset unless patch #1 has been acked by the platform person.

I have the first 3 patches in my queue, so yes I've acked it.  It's
probably easiest if the remaining 3 go through my queue once they've
been acked - or if you prefer, you can push #4 via your tree once I've
got Linus to pull my tree.  Let me know either way.

Paul.
