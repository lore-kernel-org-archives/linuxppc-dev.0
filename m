Return-Path: <SRS0+e80093b101f9c1e1d3ee+1867+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91E2DDDF15
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 18:35:25 +1000 (EST)
Date: Fri, 3 Oct 2008 04:35:22 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Block device for the ISS simulator
Message-ID: <20081003083522.GB25683@infradead.org>
References: <20081003000904.0A812DDEEE@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081003000904.0A812DDEEE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 10:08:42AM +1000, Benjamin Herrenschmidt wrote:
> The ISS simulator is a simple powerpc simulator used among other things
> for hardware bringup. It implements a simple memory mapped block device
> interface.
> 
> This is a simple block driver that attaches to it. Note that the choice
> of a major device number is fishy, though because it's a simulator and
> not real hardware, it's not necessarily a big deal.

Please don't put in more block devices for every bloody simulator in the
world.  Just emulated some simpler enough existing hardware.
