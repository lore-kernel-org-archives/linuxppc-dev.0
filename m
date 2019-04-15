Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB90C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:34:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7539206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 07:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7539206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jKyW3zV9zDqKL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jKwv6BFWzDqBl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 17:33:19 +1000 (AEST)
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1hFw6y-0001BF-In; Mon, 15 Apr 2019 09:33:04 +0200
Date: Mon, 15 Apr 2019 09:33:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
In-Reply-To: <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904150931170.4917@nanos.tec.linutronix.de>
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com>
 <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
 <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
 <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: Andra Danciu <andradanciu1997@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Apr 2019, Daniel Baluta wrote:
> On Mon, Apr 15, 2019 at 10:26 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
> > On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> > > > -// SPDX-License-Identifier: GPL
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > According to Documentation/process/license-rules.rst this should be:
> > >
> > > // SPDX-License-Identifier: GPL-2.0
> >
> 
> Actually, according to
> 
> https://spdx.org/licenses/GPL-2.0-only.html
> 
> GPL-2.0 is another name for GPL-2.0-only

See also: LICENSES/preferred/GPL-2.0

    Valid-License-Identifier: GPL-2.0
    Valid-License-Identifier: GPL-2.0-only

If the identifier would be invalid, scripts/spdxcheck.py would complain ...

Thanks,

	tglx

