Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D2A9DDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 09:12:22 +1000 (EST)
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707131619.54898.arnd@arndb.de>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 14 Jul 2007 09:12:08 +1000
Message-Id: <1184368328.6059.271.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: James Bottomley <James.Bottomley@steeleye.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-13 at 16:19 +0200, Arnd Bergmann wrote:
> I'm pretty sure that no ppc64 machine needs alias resolution in the kernel,
> although some are VIPT. Last time we discussed this, Segher explained it
> to me, but I don't remember which way Cell does it. IIRC, it automatically
> flushes cache lines that are accessed through aliases. 

Ah yes, I remember reading about this automatic flushing thing. I don't
know how the caches actually work on most of our PPC's, but the fact is,
we don't have aliasing issues, so I can safely ignore it for a bit
longer :-)

There are some aliasing issues with the instruction cache specifically
on some 4xx models but that's irrelevant to this discussion (and I think
we handle them elsewhere anyway).

Ben.
