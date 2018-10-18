Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93FC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:10:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73F12098A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="owCL9WWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73F12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bTt20ftnzDqf2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:10:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="owCL9WWq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=verge.net.au
 (client-ip=202.4.237.240; helo=kirsty.vergenet.net;
 envelope-from=horms@verge.net.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=verge.net.au header.i=@verge.net.au header.b="owCL9WWq";
 dkim-atps=neutral
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 42bTlL54dpzF3JZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:04:14 +1100 (AEDT)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7491225B853;
 Fri, 19 Oct 2018 00:04:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1539867854; bh=0/e++dXnhk4VqjzvYIRoLenXLXr4Ifh2wEHuGPjelpA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=owCL9WWqh0JZ8pQHZm7GtUGR6YXJWTSzSLuIyjSVaEZgu52e5OLsq9/kbxrRodJGj
 ervVye76bB3weKHHDP4/NKrEoaMC3Mbkmoeh6cVcDi46UZQtx596F5F5/dXFWHebZ8
 0m9YX/zIguqZCRRSuZgIvyF6yDsd6gQUYbx/1ycw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 57D94940162; Thu, 18 Oct 2018 15:04:11 +0200 (CEST)
Date: Thu, 18 Oct 2018 15:04:11 +0200
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
Message-ID: <20181018130411.vbammbqqiyvmmcxo@verge.net.au>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
 <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
 <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 08, 2018 at 09:59:19AM -0500, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 2:05 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> > > In preparation to convert board-level bindings to json-schema, move
> > > various misc SoC bindings out to their own file.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Looks good to me, but needs a rebase, as the PRR section has been extended
> > in -next.
> 
> Is this something you all can apply still for 4.20?

Sorry, missing this until now. It was too late.

Shall I take it for v4.21?
