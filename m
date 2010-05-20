Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 May 2010 16:17:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
Message-ID: <20100520061739.GE25892@yookeroo>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
	<20100520011820.GT25892@yookeroo>
	<AANLkTily6AYGJbvTx-4MJm7HKeRWOuB9jpPzgVmys1sm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTily6AYGJbvTx-4MJm7HKeRWOuB9jpPzgVmys1sm@mail.gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 19, 2010 at 08:46:19PM -0500, Timur Tabi wrote:
> On Wed, May 19, 2010 at 8:18 PM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> 
> > Couldn't you use the configurable padding, but put the stuff to do it
> > into u-boot.  i.e. repad the dtb at u-boot build time, rather than
> > u-boot runtime.
> 
> That's what I was trying to do.   Take a look at this thread:
> 
> http://lists.denx.de/pipermail/u-boot/2010-May/071520.html

Um.. what?  As far as I can tell that thread is about runtime
expanding the space given to the dtb.  I'm talking about altering the
padding on the file before giving it to u-boot in the first place.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
