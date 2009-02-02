Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F6E7DDF40
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 08:22:58 +1100 (EST)
Subject: Re: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Anholt <eric@anholt.net>
In-Reply-To: <1233608464.4932.15.camel@gaiman>
References: <20090202055559.8D600DDF51@ozlabs.org>
	<1233608464.4932.15.camel@gaiman>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 08:21:28 +1100
Message-Id: <1233609688.18767.118.camel@pasglop>
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org,
	dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> Could this comment instead be maybe:
> 
> Because the kernel-userspace ABI is fixed at a 32-bit offset, while PCI
> resources may live above that, we ignore the map offset for maps of type
> _DRM_FRAMEBUFFER or _DRM_REGISTERS.  It is assumed that each driver will
> have only one resource of each type.
> 
> (I want to remember later what exact ABI problem was in question)

Fair enough. I'll repost.

Cheers,
Ben.
