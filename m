Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 150EA1A01A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 15:28:21 +1000 (EST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 390D8140171
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 15:28:19 +1000 (EST)
Message-ID: <1406784487.29414.328.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 31 Jul 2014 00:28:07 -0500
In-Reply-To: <53D9C77D.8070203@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
 <loom.20140728T081519-636@post.gmane.org>
 <1406663895.29414.240.camel@snotra.buserror.net>
 <53D96906.1040407@Freescale.com>
 <1406773805.29414.302.camel@snotra.buserror.net>
 <53D9C77D.8070203@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 23:35 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 07/30/2014 09:30 PM, Scott Wood wrote:
> > On Wed, 2014-07-30 at 16:52 -0500, Emil Medve wrote:
> >>>>>> +			mdio0: mdio <at> fc000 {
> >>>>>> +			};
> >>>>>
> >>>>> Why is the empty node needed?
> >>>>
> >>>> For the label
> >>>
> >>> For mdio-parent-bus, or is there some other dts layer that makes this
> >>> node non-empty?
> >>
> >> 'powerpc/corenet: Create the dts components for the DPAA FMan' -
> >> http://patchwork.ozlabs.org/patch/370872
> > 
> > Why does this patch define the mdio0 label for mdio@e1120, but not
> > define a label for any other node?
> 
> Only MDIO controllers that are pinned out have these labels. Only pinned
> out MDIO(s) are capable of controlling external PHY(s) via these board
> level MDIO buses

Is there any reason to describe non-pinned-out MDIO controllers at all?
Is the lack of pinning out inherent to the silicon, or is it board
design/config?  Is the answer different for different MDIO controllers?
I'm just curious why mdio@e1120 is labelled in a non-board dtsi while
others are labelled elsewhere.

-Scott
