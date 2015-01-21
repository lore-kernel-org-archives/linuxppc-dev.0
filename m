Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7962C1A0CEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 17:29:14 +1100 (AEDT)
Received: by mail-pa0-f47.google.com with SMTP id lj1so6548753pab.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:29:12 -0800 (PST)
Date: Tue, 20 Jan 2015 22:29:02 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] Add master mode, tmd and right-j mode
 support
Message-ID: <20150121062901.GA4350@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <CAOMZO5DcpSsRi4UE8gCjT+w=OueB1pWtQPYphgeEsMNZ_EvK5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5DcpSsRi4UE8gCjT+w=OueB1pWtQPYphgeEsMNZ_EvK5w@mail.gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com,
 Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@tabi.org>,
 Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2015 at 11:15:54PM -0200, Fabio Estevam wrote:

> Not related to your series, but do you have a patch for imx6sx-sdb.dts
> that adds sai support?
> 
> In the FSL version they use 'fsl,sdma-event-remap' property to specify
> the SAI sdma channels, but this is not present in mainline? How are
> you dealing with it?

I think he must have those patches applied to his own local branch
as I do :)

I was quite hesitating to send them because the SDMA one doesn't
look flawless, plus I don't know SDMA owner's plan for upstream.

Nicolin
