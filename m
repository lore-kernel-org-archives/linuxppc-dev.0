Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3173DDDFC7
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:16:12 +1000 (EST)
Date: Mon, 21 Jul 2008 11:14:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Message-ID: <20080721161433.GD13185@loki.buserror.net>
References: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
	<20080716214722.GA6251@ld0162-tx32.am.freescale.net>
	<20080716215745.GA17093@redhat.com>
	<37829F82-D71C-4B42-A752-DA86C6F2764D@kernel.crashing.org>
	<20080716221949.GA18148@redhat.com>
	<BB883309-0856-4371-BFC3-68E2F54B5B29@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB883309-0856-4371-BFC3-68E2F54B5B29@kernel.crashing.org>
Cc: Dave Jones <davej@redhat.com>, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 05:55:17PM -0500, Kumar Gala wrote:
> It looks like the simplest solution at this point is to unconditionally 
> select the PHYLIB for this board.  We should look at moving the low level 
> mdio bitbang ops out so they can be built as a module.

Or exporting the MDIO/MDC pins through the GPIO API.

-Scott
