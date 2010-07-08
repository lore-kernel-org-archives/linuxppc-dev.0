Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8219B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 16:30:26 +1000 (EST)
Subject: Re: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: lawrence rust <lawrence@softsystem.co.uk>
In-Reply-To: <1278569907.1411.19.camel@gagarin>
References: <1278181316.3232.45.camel@gagarin>
	<1278565221.28659.74.camel@pasglop> <1278569907.1411.19.camel@gagarin>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 16:30:20 +1000
Message-ID: <1278570620.28659.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-08 at 08:18 +0200, lawrence rust wrote:
> 
> Sure. it would be preferable but unfortunately the PowerMac on-board IDE
> controller (CONFIG_BLK_DEV_IDE_PMAC), used for the DVD drive on B/W
> G3's, doesn't have a PATA equivalent.  So it's pragmatic (until the IDE
> code is removed) to use the IDE cmd64x driver to minimise kernel code
> size.

Sure it does nowadays: drivers/ata/pata_macio.c :-)

I merged that upstream in december last year, so it didn't make 2.6.32
which your distro probably uses, but it is in .33 and later.

> A minor correction to my previous post, the first version of Ubuntu to
> suffer from this problem was 9.10. 

Cheers,
Ben.
