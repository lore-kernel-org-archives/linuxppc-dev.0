Return-Path: <dgibson@ozlabs.org>
Date: Wed, 30 Nov 2011 17:31:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] 44x/currituck: Add support for the new IBM currituck
 platform
Message-ID: <20111130063122.GI5435@truffala.fritz.box>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
 <1322634022.21641.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322634022.21641.61.camel@pasglop>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 30, 2011 at 05:20:22PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-11-30 at 16:24 +1100, Tony Breeds wrote:
> 
> > +		cpu@1 {
> > +			device_type = "cpu";
> > +			model = "PowerPC,476";
> > +			reg = <1>;
> > +			clock-frequency = <1600000000>; // 1.6 GHz
> > +			timebase-frequency = <100000000>; // 100Mhz
> > +			i-cache-line-size = <32>;
> > +			d-cache-line-size = <32>;
> > +			i-cache-size = <32768>;
> > +			d-cache-size = <32768>;
> > +			dcr-controller;
> > +			dcr-access-method = "native";
> > +			status = "disabled";
> 
> disabled ? really ?

This is ePAPR.  All non-boot CPUs are supposed to have status =
"disabled" to indicate that they won't be available until explicitly
enabled via the enable-method.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
