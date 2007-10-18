Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 22:54:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
Message-ID: <20071018125440.GC13563@localhost.localdomain>
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
	<47175683.1030407@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47175683.1030407@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 02:50:11PM +0200, Wolfgang Grandegger wrote:
> Hello,
> 
> I see one more issue.
> 
> Marian Balakowicz wrote:
> > Add device tree source file for Motion-PRO board.
> > 
> > Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> > ---
> [deletions]
> > +		gpio@b00 {
> > +			compatible = "mpc5200b-gpio\0mpc5200-gpio";
> > +			reg = <b00 40>;
> > +			interrupts = <1 7 0>;
> > +			interrupt-parent = <&mpc5200_pic>;
> > +		};
> 
> Do we not need the field "device_type = "gpio" here?

No, we really don't.  If there's any "class" of devices that *don't*
deserve a device_type it would be gpios.

Oh, also dtc can now do the compatible properties as:
	compatible = "mpc5200b-gpio", "mpc5200-gpio";

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
