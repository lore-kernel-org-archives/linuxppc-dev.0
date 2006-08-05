Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFDCB679E9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 11:12:43 +1000 (EST)
Subject: Re: [PATCH] Fix powerpc 44x_mmu build
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt Porter <mporter@embeddedalley.com>
In-Reply-To: <20060804164401.GB4959@gate.crashing.org>
References: <20060804164401.GB4959@gate.crashing.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 20:12:22 -0500
Message-Id: <1154740342.2847.6.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-04 at 11:44 -0500, Matt Porter wrote:
> The PIN_SIZE definition name changed, update 44x_mmu.c accordingly.

As far as I know, 4xx still builds as ARCH=ppc...  is this patch just
something you noticed, or is it a hint that you're working on moving 4xx
to arch/powerpc?

Just curious, since I've been poking at this a bit and would rather not
duplicate effort.

josh
