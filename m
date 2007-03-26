Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Mar 2007 09:10:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
Message-ID: <20070326231052.GB24598@localhost.localdomain>
References: <1174681120.32390.82.camel@ld0161-tx32> <E1HVpSK-0004M3-6D@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1HVpSK-0004M3-6D@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2007 at 08:41:52AM -0500, Jon Loeliger wrote:
> So, like, the other day Jon Loeliger mumbled:
> > 
> > Keeps track of open files in a stack, and assigns
> > a filenum to source positions for each lexical token.
> > Modified error reporting to show source file as well.
> > No policy on file directory basis has been decided.
> > Still handles stdin.
> > 
> > Tested on all arch/powerpc/boot/dts DTS files
> > 
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> Applied.

Erg.  I was going to comment on this, but I've been sick this week.  I
like the idea, but I'm not real happy with some of the details.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
