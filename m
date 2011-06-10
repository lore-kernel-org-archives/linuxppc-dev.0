Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EB53B6FF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 21:13:44 +1000 (EST)
Date: Fri, 10 Jun 2011 11:45:51 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Message-ID: <20110610104551.GB26441@sirena.org.uk>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de> <4DF12A94.6070605@freescale.com>
	<201106092233.08030.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201106092233.08030.arnd@arndb.de>
Cc: konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, linux-console@vger.kernel.org, greg@kroah.com,
	virtualization@lists.linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2011 at 10:33:07PM +0200, Arnd Bergmann wrote:
> On Thursday 09 June 2011 22:18:28 Timur Tabi wrote:

> > Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
> > is important, and changing the type will break my existing apps.  Are you
> > insisting that I pick a new number?

> I definitely insist that you have a proper interface in the driver at the
> time that it gets merged, and that probably includes a collision-free
> ioctl code.

This sort of stuff is one of the issues that should be being factored in
to any decision not to publish and submit the kernel code - ABIs that
haven't been reviewed upstream may well have this sort of issue.
