Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z21sX667pzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 04:26:40 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id m26so12825239pfj.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 09:26:40 -0800 (PST)
Date: Wed, 20 Dec 2017 09:26:33 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name,
 lukma@denx.de, Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
Message-ID: <20171220172632.GA19904@Asurada-Nvidia>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
 <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
 <20171218230220.GA16161@Asurada-Nvidia>
 <CAG5mAdzPuUo8SkJ_AqrgrouLWash4tge4YG7EMrdCTv9=K5FOQ@mail.gmail.com>
 <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 20, 2017 at 12:40:37PM +0100, Arnaud Mouiche wrote:
> >>>Ugh, so it's basically quite broken again -- before these patches.
> >>I remember Arnaud reviewed one of my changes back to September.
> >>So I suppose the test should be fine at that time -- so a change
> >>being merged recently might have impacted the test result.

> Sorry but I will be busy until mid January, I could help testing and
> fixing broken multi channel after.
> Anyway, I don't see specific issues with Nicolin patches.
> We can take time to fix what was broken before this patch set... after.

I won't be able to fix and re-submit patches either during the
holidays. So let's discuss this in earlier January. Thanks for
joining.

Nicolin
