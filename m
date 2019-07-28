Return-Path: <SRS0=fO6x=VZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F93C7618F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 20:10:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156882070B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jul 2019 20:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156882070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xYpB4JGnzDqS4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 06:10:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 2378 seconds by postgrey-1.36 at bilbo;
 Mon, 29 Jul 2019 06:08:32 AEST
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xYmJ6wzgzDqQc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 06:08:32 +1000 (AEST)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1hrooV-0004HX-5J; Sun, 28 Jul 2019 14:26:36 -0500
Message-ID: <2243421e574c72c5e75d27cc0122338e2e0bde63.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Valentin Longchamp <valentin@longchamp.me>,
 linuxppc-dev@lists.ozlabs.org,  galak@kernel.crashing.org
Date: Sun, 28 Jul 2019 14:26:34 -0500
In-Reply-To: <CADYrJDwvwVThmOwHZ4Moqenf=-iqoHC+yJ_uxtrD8sDso33rjg@mail.gmail.com>
References: <20190714200501.1276-1-valentin@longchamp.me>
 <CADYrJDwvwVThmOwHZ4Moqenf=-iqoHC+yJ_uxtrD8sDso33rjg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: valentin@longchamp.me, linuxppc-dev@lists.ozlabs.org,
 galak@kernel.crashing.org, madalin.bucur@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/kmcent2: update the ethernet devices' phy
 properties
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2019-07-28 at 18:01 +0200, Valentin Longchamp wrote:
> Hi Scott, Kumar,
> 
> Looking at this patch I have realised that I had already submitted it
> to the mailing list nearly 2 years ago:
> https://patchwork.ozlabs.org/patch/842944/
> 
> Could you please make sure that this one gets merged in the next
> window, so that I avoid forgetting such a patch a 2nd time ?
> 
> Thanks a lot

I added it to my patchwork todo list; thanks for the reminder.

> Le dim. 14 juil. 2019 à 22:05, Valentin Longchamp
> <valentin@longchamp.me> a écrit :
> > 
> > Change all phy-connection-type properties to phy-mode that are better
> > supported by the fman driver.
> > 
> > Use the more readable fixed-link node for the 2 sgmii links.
> > 
> > Change the RGMII link to rgmii-id as the clock delays are added by the
> > phy.
> > 
> > Signed-off-by: Valentin Longchamp <valentin@longchamp.me>

I don't see any other uses of phy-mode in arch/powerpc/boot/dts/fsl, and I see
lots of phy-connection-type with fman.  Madalin, does this patch look OK?

-Scott

> > ---
> >  arch/powerpc/boot/dts/fsl/kmcent2.dts | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts
> > b/arch/powerpc/boot/dts/fsl/kmcent2.dts
> > index 48b7f9797124..c3e0741cafb1 100644
> > --- a/arch/powerpc/boot/dts/fsl/kmcent2.dts
> > +++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
> > @@ -210,13 +210,19 @@
> > 
> >                 fman@400000 {
> >                         ethernet@e0000 {
> > -                               fixed-link = <0 1 1000 0 0>;
> > -                               phy-connection-type = "sgmii";
> > +                               phy-mode = "sgmii";
> > +                               fixed-link {
> > +                                       speed = <1000>;
> > +                                       full-duplex;
> > +                               };
> >                         };
> > 
> >                         ethernet@e2000 {
> > -                               fixed-link = <1 1 1000 0 0>;
> > -                               phy-connection-type = "sgmii";
> > +                               phy-mode = "sgmii";
> > +                               fixed-link {
> > +                                       speed = <1000>;
> > +                                       full-duplex;
> > +                               };
> >                         };
> > 
> >                         ethernet@e4000 {
> > @@ -229,7 +235,7 @@
> > 
> >                         ethernet@e8000 {
> >                                 phy-handle = <&front_phy>;
> > -                               phy-connection-type = "rgmii";
> > +                               phy-mode = "rgmii-id";
> >                         };
> > 
> >                         mdio0: mdio@fc000 {
> > --
> > 2.17.1
> > 
> 
> 

