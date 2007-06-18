Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 0773EDDEFB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 06:27:41 +1000 (EST)
Date: Mon, 18 Jun 2007 13:25:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Message-ID: <20070618202518.GG8740@mag.az.mvista.com>
References: <20070618185715.321010@gmx.net>
	<20070618191529.GC8740@mag.az.mvista.com>
	<20070618194359.321010@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070618194359.321010@gmx.net>
Cc: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 09:43:59PM +0200, Gerhard Pircher wrote:
> Von: "Mark A. Greer" <mgreer@mvista.com>
> > On Mon, Jun 18, 2007 at 08:57:15PM +0200, Gerhard Pircher wrote:
> > 
> > > 1. The AmigaOne makes use of different G3...
> > 
> > I'm far from an authoritative figure on this but making a
> > reasonable default (in your dts file) then updating in the 
> > bootwrapper makes sense to me.  That's what I did for several 
> > properties in the prpmc2800's dts.
> So, the bootwrapper should update the name property of the CPU node. Is the cpu node name used somewhere?

Oh, sorry I really talking about the cpu frequencies, etc.
I don't think the name of the cpu node matters but I'd have to check.
Others probably know off the top of their heads.

Mark
