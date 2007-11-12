Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Nov 2007 09:43:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] Merge dtc and libfdt upstream source
Message-ID: <20071112224327.GE1219@localhost.localdomain>
References: <20071112041126.GB2047@localhost.localdomain>
	<20071112041524.C6C5FDDED2@ozlabs.org>
	<20071112171240.GA4394@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071112171240.GA4394@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 12, 2007 at 11:12:40AM -0600, Scott Wood wrote:
> On Mon, Nov 12, 2007 at 03:15:24PM +1100, David Gibson wrote:
> > This very large patch incorporates a copy of dtc (including libfdt)
> > into the kernel source, in arch/powerpc/boot/dtc-src.  This patch only
> > imports the upstream sources verbatim, later patches are needed to
> > actually link it into the kernel Makefiles and use the embedded code
> > during the kernel build.
> 
> Maybe it should go somewhere outside arch/powerpc, so it can be used by
> other architectures down the road.

If other architectures want to use it down the road, we can move it
down the road.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
