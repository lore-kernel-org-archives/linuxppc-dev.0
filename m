Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 10:31:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 07/19] bootwrapper: Modify *pp, not *p, in ft_shuffle().
Message-ID: <20070313233107.GA25514@localhost.localdomain>
References: <20070312204148.GG28545@ld0162-tx32.am.freescale.net>
	<20070313215831.GB8072@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313215831.GB8072@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 02:58:31PM -0700, Mark A. Greer wrote:
> On Mon, Mar 12, 2007 at 02:41:48PM -0600, Scott Wood wrote:
> > Move the caller's pointer back to match the change in the region's start,
> > rather than alter a byte of the device tree's content.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> Acked-by: Mark A. Greer <mgreer@mvista.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
