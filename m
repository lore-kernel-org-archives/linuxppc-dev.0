Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B5F0DDF64
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:46:05 +1000 (EST)
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070530101348.GD24586@lst.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com> <20070529104948.GC29351@lst.de>
	<Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
	<20070530101348.GD24586@lst.de>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:45:55 +1000
Message-Id: <1180525555.19517.268.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 12:13 +0200, Christoph Hellwig wrote:
> 
> For any sane hypervisor or hardware the copy should be worth
> than that.  Then again a sane hardware or hypervisor would support
> SG requests..

Agreed... Sony should fix that, it's a bit ridiculous.

Ben.
