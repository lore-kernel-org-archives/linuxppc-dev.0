Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:58:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Message-ID: <20070907005803.GJ26079@localhost.localdomain>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192116.GH32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:21:16PM -0500, Scott Wood wrote:
> This target produces a flat binary rather than an ELF file,
> fixes the entry point at the beginning of the image, and takes
> a complete device tree with no fixups needed.
> 
> The device tree must have labels on /#address-cells, the timebase
> frequency, and the memory size.

Hrm... the actual contents of this patch are less about producing an
unheadered binary image than they are about introducing the "raw"
platform.  I don't mind the idea of a "raw" platform (although I'm not
sure I like that name for it), but the patch comment needs work.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
