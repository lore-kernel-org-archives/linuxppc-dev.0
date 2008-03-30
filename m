Return-Path: <dgibson@ozlabs.org>
Date: Sun, 30 Mar 2008 21:11:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 6/9] [POWERPC] prpmc2800: clean up dts properties
Message-ID: <20080330101128.GA20077@localhost.localdomain>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234900.GF30214@farnsworth.org>
	<20080329215942.GB27226@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080329215942.GB27226@lixom.net>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 29, 2008 at 04:59:42PM -0500, Olof Johansson wrote:
> On Fri, Mar 28, 2008 at 04:49:00PM -0700, Dale Farnsworth wrote:
> > From: Mark A. Greer <mgreer@mvista.com>
> > 
> > Remove several unused (or software config only) properties.
> > Rename marvel node to "soc".  Technically, it's not an SOC,
> > but its organization is the same as an SOC.  Also, rename the
> > "block-index" property to "cell-index" to conform to current
> > practice.
> 
> I see this rename as purely misleading. It isn't an soc, so it shouldn't
> be named as such. Call it system-controller or something. Pretty much
> any other name is better. :-)

I agree.  system-controller, host-bridge, north-bridge, maybe, but not
soc.  With current conventions, the node name is primarily for the
benefit of human readers, so if it misleads it has failed entirely in
its purpose.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
