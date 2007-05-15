Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 15:47:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515054758.GC6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 07:11:07AM +0200, Segher Boessenkool wrote:
> Just a few more things...
> 
> >  	plb {
> > -		device_type = "ibm,plb";
> >  		compatible = "ibm,plb-440gp", "ibm,plb4";
> 
> You match on "ibm,plb" though.  Well you got one
> in three right ;-)

Indeed.  And I'm still not sure how it's recognizing the plb devices
right now...

> > +		SDRAM0: memory-controller {
> >  			compatible = "ibm,sdram-440gp", "ibm,sdram";
> 
> "ibm,sdram" is way too generic to ever be usefully
> used for device matching.

Yeah, I guess this should be ibm,sdram-44x or ibm,sdram-4xx.  Better
go look up if any 40x chips use a similar sdram controller.

> > +		SRAM0: sram {
> > +			compatible = "ibm,sram440gp";
> 
> You spell this one without a dash, all others with one.

Ah, yes, oops...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
