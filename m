Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E83EBDDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 17:46:27 +1000 (EST)
Date: Mon, 24 Sep 2007 09:46:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/2] qemu platform, v2
Message-ID: <20070924074602.GA19514@lst.de>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
	<20070924040047.GK8058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070924040047.GK8058@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 02:00:47PM +1000, David Gibson wrote:
> Basically because PReP support doesn't work under arch/powerpc.
> Getting it working properly is something that should happen, but will
> take a while.  In the meantime, getting something that's sufficient to
> get working under just qemu's version of prep, without using the
> abominable openhackware is a quicker path to a usable arch/powerpc
> kernel under qemu.

Sounds fair.  Care to add something like this to the Kconfig help
text?
