Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Dec 2007 09:10:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071214221008.GB21311@localhost.localdomain>
References: <20071211212247.GB3620@loki.buserror.net>
	<EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
	<20071214155341.GB16269@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214155341.GB16269@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 09:53:41AM -0600, Scott Wood wrote:
> On Thu, Dec 13, 2007 at 11:19:33PM -0600, Kumar Gala wrote:
> > Can we make this a /dts-v1/; since its new.
> 
> It's not really new; it's just been collecting dust for a while. :-P
> 
> Are there any tools to autoconvert (preferably without losing
> comments)?

dtc itself can convert, but it will lose comments, alas.  There's not
really any reasonable way it can be changed to preserve comments.

	dtc -I dts -O dts foo.dts

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
