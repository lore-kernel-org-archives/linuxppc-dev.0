Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 10:42:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
Message-ID: <20080109234215.GA17153@localhost.localdomain>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 08:58:17AM -0700, Grant Likely wrote:
> Hi Leo,
> 
> comments below.  I've made my comments on the first file, but they
> apply to the other two also.
> 
> Cheers,
> g.

[snip]
> > +               ranges = <0 e0000000 00100000>;
> > +               reg = <e0000000 00000200>;
> > +               bus-frequency = <0>;
> > +
> > +               wdt@200 {
> > +                       compatible = "mpc83xx_wdt";
> 
> "fsl,mpc8377_wdt", "fsl,mpc83xx_wdt" as per generic names recommended practice.

Uh.. that's reasonable advice, but it has nothing to do with the
generic names recommended practice.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
