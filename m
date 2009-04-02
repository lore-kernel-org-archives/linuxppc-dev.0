Return-Path: <bzolnier@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id A9766DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 06:44:18 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so286174mue.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Apr 2009 12:44:15 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
Date: Thu, 2 Apr 2009 21:08:32 +0200
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
	<alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
	<49D1E384.8080009@toshiba.co.jp>
In-Reply-To: <49D1E384.8080009@toshiba.co.jp>
MIME-Version: 1.0
Message-Id: <200904022108.32808.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	IDE/ATA Devel <linux-ide@vger.kernel.org>,
	Grant Grundler <grundler@google.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	LKML <linux-kernel@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 31 March 2009, KOBAYASHI Yoshitake wrote:
> 2009/03/31 16:51, Geert Uytterhoeven wrote:
> > On Mon, 30 Mar 2009, Grant Grundler wrote:
> >> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> >> email on March 14th:
> >>     http://lkml.org/lkml/2009/3/14/17
> >>
> >> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> >> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> >> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> >> someone else
> >> would know or would be able to ACK this patch.
> > 
> > tx49xx is MIPS, for Nemoto-san.
> 
> The patch looks good for Toshiba Cell Reference Set.

Great, I applied the patch.

Thanks,
Bart
