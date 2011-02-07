Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Feb 2011 19:29:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
Message-ID: <20110207082934.GA28943@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230643.GF3032@yookeroo>
	<1296691225.12290.112.camel@shaggy-w500>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296691225.12290.112.camel@shaggy-w500>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 02, 2011 at 06:00:25PM -0600, Dave Kleikamp wrote:
> On Thu, 2011-02-03 at 10:06 +1100, David Gibson wrote:
> > On Tue, Feb 01, 2011 at 12:48:41PM -0600, Dave Kleikamp wrote:
> > > so that it can use information from the device tree.
> > 
> > Hrm.  On the other hand this means that the early_init_devtree() code
> > can't benefit from hardcoded early debugging.  Since you don't
> > actually appear to use devtree information in udbg_early_init() in the
> > latest series, I'd suggest dropping this patch.
> 
> Patch 2 depends on early_init_devtree() being run.  Until then, I don't
> know of a way to get at the bootargs.

Ah, yes.  Drat.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
