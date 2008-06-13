Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Jun 2008 14:19:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
Message-ID: <20080613041943.GC29451@yookeroo.seuss>
References: <200806121344.26883.david.jander@protonic.nl>
	<fa686aa40806120710g67761ectfee1e3f0916b0eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40806120710g67761ectfee1e3f0916b0eb@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 08:10:47AM -0600, Grant Likely wrote:
[snip]
> > +               i2ccontrol@1760 {
> > +                       compatible = "fsl,mpc5121-i2c-ctrl";
> > +                       reg = <0x1760 0x8>;
> > +               };
> > +
> > +               diu@2100 {
> 
> (nitpick) There is a recommended practice that says node names should
> be generic as much as possible, so I think this should probably be
> video@2100.  The compatible value is fine.

If this is a video display device, the recommended generic name is
"display@XX", not "video@XX".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
