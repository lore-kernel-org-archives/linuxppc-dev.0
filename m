Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97C391A04EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 10:21:54 +1100 (AEDT)
Message-ID: <1414711297.23458.173.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3] powerpc/dts: Factorize the clock control node
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 30 Oct 2014 18:21:37 -0500
In-Reply-To: <54524405.5090509@Freescale.com>
References: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
 <1414538500.23458.125.camel@snotra.buserror.net>
 <54524405.5090509@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: yuantian.tang@Freescale.com, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-30 at 08:58 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 10/28/2014 06:21 PM, Scott Wood wrote:
> > On Wed, 2014-10-22 at 09:42 -0500, Emil Medve wrote:
> >> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> >> Change-Id: I25ce24a25862b4ca460164159867abefe00ccdd1
> > 
> > Please remove gerrit stuff prior to submitting.
> 
> I did remove the bulk of it. I wanted to keep the Change-Id so I can
> easily correlate the upstream patches with the sordid internal history.
> Seems the upstream history has enough instances of 'Change-Id' for this
> not to be an issue

OK...

> > I don't think the mux stuff belongs here, given that clockgen2.dtsi
> > doesn't have it, and I saw at least one clockgen1 user needing to
> > supplement this with more muxes.
> 
> The intent was to put here devices/nodes that are common per chassis
> from the low to high end. Specific SoC would change/augment this as
> appropriate. I could have put each node in its own file as we've done
> elsewhere, but I thought it would be too much
> 
> Yes, chassis v1 and v2 have differences, but that's not unexpected

It just strikes me as being an awkward split of where each mux node
goes.  Is it guaranteed by the chassis that all v1 will have at least
the first two muxes?

> >> @@ -1068,7 +1043,6 @@
> >>  			clocks = <&sysclk>;
> >>  			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
> >>  		};
> >> -
> >>  		pll3: pll3@860 {
> >>  			#clock-cells = <1>;
> >>  			reg = <0x860 0x4>;
> >> @@ -1076,7 +1050,6 @@
> >>  			clocks = <&sysclk>;
> >>  			clock-output-names = "pll3", "pll3-div2", "pll3-div4";
> >>  		};
> >> -
> >>  		pll4: pll4@880 {
> >>  			#clock-cells = <1>;
> >>  			reg = <0x880 0x4>;
> > 
> > Why?
> 
> Why what?

Why are you removing all these blank lines?

-Scott
