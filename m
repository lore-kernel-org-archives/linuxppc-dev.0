Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21A131A0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 09:33:23 +1000 (EST)
Message-ID: <1412033580.13320.295.camel@snotra.buserror.net>
Subject: Re: [PATCH][V2] Freescale Frame Manager Device Tree binding document
From: Scott Wood <scottwood@freescale.com>
To: Bob Cochran <ppc@mindchasers.com>
Date: Mon, 29 Sep 2014 18:33:00 -0500
In-Reply-To: <5425962F.7090602@mindchasers.com>
References: <1410952110-32733-1-git-send-email-igal.liberman@freescale.com>
 <5425962F.7090602@mindchasers.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "Igal.Liberman" <igal.liberman@freescale.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Emilian.Medve@freescale.com,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-26 at 12:37 -0400, Bob Cochran wrote:
> On 09/17/2014 07:08 AM, Igal.Liberman wrote:
> > From: Igal Liberman <Igal.Liberman@freescale.com>
> >
> > The Frame Manager (FMan) combines the Ethernet network interfaces with packet
> > distribution logic to provide intelligent distribution and queuing decisions
> > for incoming traffic at line rate.
> >
> > This binding document describes Freescale's Frame Manager hardware attributes
> > that are used by the Frame Manager driver for its basic initialization and
> > configuration.
> >
> > Difference between [V1] and [V2]:
> > Addressed all comments recieved from Scott in [V1]
> >
> > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> 
> 
> Is there a reference (FMAN) dts file I can compare this against?  I was 
> reviewing this against my (combined) dts file for my t1040rdb built with 
> either FSL's SDK1.6 or Yocto Project meta-fsl-ppc master branch, and I'm 
> not finding a good match between the nodes / properties in my dts file 
> and what you have here.
> 
> For example, I don't find the required "clocks" or 
> "fsl,qman-channel-range" properties under my <fman0: fman@400000 ...> 
> node.
> 	
> I'm wondering if this document is trailing or leading the source in the 
> latest published FSL SDK (1.6).

The SDK's device tree binding was not considered suitable and we've
started from scratch for upstream.

-Scott
