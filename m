Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6363ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:52:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FC220817
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC220817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rb7P6dX7zF3Tl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:52:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bootlin.com
 (client-ip=62.4.15.54; helo=mail.bootlin.com;
 envelope-from=thomas.petazzoni@bootlin.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 42rSfF1PD9zF3Qx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 02:59:45 +1100 (AEDT)
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0DCF7207B8; Thu,  8 Nov 2018 16:59:41 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr
 [90.88.15.49])
 by mail.bootlin.com (Postfix) with ESMTPSA id 74344206D8;
 Thu,  8 Nov 2018 16:59:40 +0100 (CET)
Date: Thu, 8 Nov 2018 16:59:40 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
Message-ID: <20181108165940.64ad52f1@windsurf>
In-Reply-To: <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
 <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Nov 2018 07:47:52 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 Olof Johansson <olof@lixom.net>, Frank Rowand <frowand.list@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

I'm jumping into the discussion, but I clearly don't have all the
context of the discussion.

On Thu, 8 Nov 2018 15:54:31 +0000, Robin Murphy wrote:

> >> This seems like a semantic different between the two representations, =
or am
> >> I missing something here? Specifically, both the introduction of
> >> interrupts-extended and also dropping any mention of using a single pe=
r-cpu
> >> interrupt (the single combined case is no longer support by Linux; not=
 sure
> >> if you want to keep it in the binding). =20
> >=20
> > In regards to no support for the single combined interrupt, it looks
> > like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
> > have only a single interrupt. Though the interrupt gets routed to MPIC
> > which then has a GIC PPI. So it isn't supported or happens to work
> > still since it is a PPI? =20
>=20
> Well, the description of the MPIC in the Armada XP functional spec says:
>=20
> "Interrupt sources ID0=E2=80=93ID28 are private events per CPU. Thus, eac=
h=20
> processor has a different set of events map interrupts ID0=E2=80=93ID28."
>=20
> Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu=20
> interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and=20
> not an SPI then there's no issue there.

The Armada XP does not have a GIC at all, but only a MPIC as the
primary interrupt controller.

However the Armada 38x has both a GIC and a MPIC, and indeed the parent
interrupts of the MPIC towards the GIC is:

	interrupts =3D <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
