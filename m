Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CFB5DDFDE
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:32:10 +1000 (EST)
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com> <20070529104948.GC29351@lst.de>
	<Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
Content-Type: text/plain
Date: Tue, 29 May 2007 21:31:59 +1000
Message-Id: <1180438319.19517.150.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 13:11 +0200, Geert Uytterhoeven wrote:
> > This looks very inefficient.  Just set sg_tablesize of your driver
> > to 1 to avoid getting mutiple segments.
> 
> The disadvantage of setting sg_tablesize = 1 is that the driver will
> get small
> requests (PAGE_SIZE) most of the time, which is very bad for
> performance.

And the joke is that not only the HW can do scatter & gather but you
also have an iommu ...

Ben.
