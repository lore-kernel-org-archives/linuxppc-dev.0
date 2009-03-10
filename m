Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8945EDE09D
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 11:07:27 +1100 (EST)
Subject: Re: Does DRI/DRM still work on non-coherent DMA platforms?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090309213034.192330@gmx.net>
References: <20090309213034.192330@gmx.net>
Content-Type: text/plain
Date: Tue, 10 Mar 2009 11:07:16 +1100
Message-Id: <1236643636.7260.198.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 22:30 +0100, Gerhard Pircher wrote:
> Hi,
> 
> I heard rumors that DRI doesn't work on SAM440EP (onboard Radeon GPU)
> boards. I had DRI halfway working on my AmigaOne (Radeon 9250) with an
> early release candidate of the 2.6.25 kernel and IIRC this patch here
> (manually applied):
> http://kerneltrap.org/index.php?q=mailarchive/git-commits-head/2008/3/30/1301044
> 
> I just tested DRI again on my A1 (I don't have a SAM board) with
> v2.6.29-rc6 and the machine looks up while starting the X server.
> Curiously DRI seems to work, if I specify "udbg-immortal" on the
> kernel command line and enable DRM debugging.
> Did anyone try out DRI on a non-coherent DMA PPC platform and can
> confirm that it still works?

It should work... try using dri-next branch from airlied tree, I had
that working on a Canyonlands after DaveM and I fixed a whole bunch of
issues. Also make sure you use the latest X side driver too.

Cheers,
Ben.
