Return-Path: <dgibson@ozlabs.org>
Date: Thu, 4 Oct 2007 11:54:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] SPI: Use fsl_spi instead of mpc83xx_spi
Message-ID: <20071004015403.GA4620@localhost.localdomain>
References: <87hcl8xkw5.fsf@macbook.be.48ers.dk>
	<fa686aa40710030852q6f88002amafd33fd773833eb5@mail.gmail.com>
	<878x6kxk62.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878x6kxk62.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 06:00:37PM +0200, Peter Korsgaard wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
> 
> Hi,
> 
>  >> -                       compatible = "mpc83xx_spi";
>  >> +                       compatible = "fsl_spi";
> 
>  Grant> Compatible is a list property; this might be more appropriate:
> 
>  Grant> compatible = "fsl,mpc8313_spi", "fsl_spi";
> 
> Fine by me, I'm just following booting-without-of.txt.

Yeah, some of the older bits of booting-without-of.txt are a bit
crufty.  There should certainly be a specific compatible value in the
list as well as the general "fsl_spi" one.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
