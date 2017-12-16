Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzZYv15bgzDrp4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 04:49:38 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e14so7563100pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 09:49:38 -0800 (PST)
Date: Sat, 16 Dec 2017 09:49:33 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Caleb Crome <caleb@crome.org>
Cc: Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name, Liam Girdwood <lgirdwood@gmail.com>,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
Message-ID: <20171216174932.GB3840@Asurada>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
 <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 16, 2017 at 09:30:14AM -0800, Caleb Crome wrote:

> Having come to work on this driver with very little knowledge about
> kernel programming, and i.MX, I have to agree with Timur. It's an
> amazingly complex driver (with support of so many variants).  By
> eliminating verbose commentary, it's also wiping away a lot of
> knowledge.  The more sparse commentary makes things harder to
> understand for newcomers, or really anybody who isn't already steeped
> in knowledge about the SSI port and linux, and it's interaction with
> DMA.

I never said that I don't agree with Timur. Every change here is
to simplify things. As long as Timur or any reviewer feels one of
new comments is harder to understand, I am totally fine to rework.
I respect everyone's opinion, but I hope everyone can respect my
effort too by telling me which one needs to rework and why?

Thanks
Nicolin
