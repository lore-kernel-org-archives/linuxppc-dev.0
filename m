Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166EC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4552146D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4552146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439dc832XczDqZR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:42:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 439dTs3Lt4zDqjT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 01:37:04 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ACBFA78;
 Thu,  6 Dec 2018 06:37:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AE883F575;
 Thu,  6 Dec 2018 06:37:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 249F41AE0BCF; Thu,  6 Dec 2018 14:37:23 +0000 (GMT)
Date: Thu, 6 Dec 2018 14:37:23 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to
 json-schema
Message-ID: <20181206143722.GA14887@arm.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-9-robh@kernel.org>
 <20181205100858.GA14619@arm.com>
 <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+YsVB8Ew=cb5W54eirMpAAOR7ApahCbHOtp2m3wpJYSg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 09:42:04AM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 4:08 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Dec 03, 2018 at 03:31:57PM -0600, Rob Herring wrote:
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - apm,potenza-pmu
> > > +              - arm,armv8-pmuv3
> > > +              - arm,cortex-a73-pmu
> > > +              - arm,cortex-a72-pmu
> > > +              - arm,cortex-a57-pmu
> > > +              - arm,cortex-a53-pmu
> > > +              - arm,cortex-a35-pmu
> > > +              - arm,cortex-a17-pmu
> > > +              - arm,cortex-a15-pmu
> > > +              - arm,cortex-a12-pmu
> > > +              - arm,cortex-a9-pmu
> > > +              - arm,cortex-a8-pmu
> > > +              - arm,cortex-a7-pmu
> > > +              - arm,cortex-a5-pmu
> > > +              - arm,arm11mpcore-pmu
> > > +              - arm,arm1176-pmu
> > > +              - arm,arm1136-pmu
> > > +              - brcm,vulcan-pmu
> > > +              - cavium,thunder-pmu
> > > +              - qcom,scorpion-pmu
> > > +              - qcom,scorpion-mp-pmu
> > > +              - qcom,krait-pmu
> > > +      - items:
> > > +          - const: arm,cortex-a7-pmu
> > > +          - const: arm,cortex-a15-pmu
> >
> > What do these last two mean?
> 
> The first list only allows a single compatible string. This list says
> there are 2 and that the compatible property should be:
> compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> 
> Which shows up here:
> arch/arm/boot/dts/sun6i-a31.dtsi:               compatible =
> "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> arch/arm/boot/dts/sun7i-a20.dtsi:               compatible =
> "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> 
> Maybe the dts is wrong and should be fixed?

Yes, that's wrong and you could end up with the kernel exposing the wrong
events to userspace. So I think we can fix the .dts and leave the binding
without this.

> > > +required:
> > > +  - compatible
> >
> > I probably said this before, but I do think that it's a shame to lose the
> > example binding, especially for something like the PMU where you can
> > pretty much take an example and bang in your own IRQ numbers to get it
> > up and running.
> 
> I just thought it is so trivial that it didn't add much. I think most
> folks would copy-n-paste from an actual dts file which has all the
> other nodes you just need to update addresses and irq nums.

True... even more of a reason to fix thise sun* .dts files then!

Will
