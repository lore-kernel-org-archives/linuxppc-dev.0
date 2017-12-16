Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzZWP05kwzDsQ8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 04:47:27 +1100 (AEDT)
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name, Liam Girdwood <lgirdwood@gmail.com>,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <01a7d97b-7e80-83b2-e850-d513d7dc35aa@tabi.org>
 <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <4680f3e1-e0c8-baa5-6ca4-85d3feb4eb87@tabi.org>
Date: Sat, 16 Dec 2017 11:47:21 -0600
MIME-Version: 1.0
In-Reply-To: <CAG5mAdw04U5gpRMqLYOBeujH=t+59WJLFeGe+Qareh-cuWsDvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/16/17 11:30 AM, Caleb Crome wrote:
> Having come to work on this driver with very little knowledge about
> kernel programming, and i.MX, I have to agree with Timur. It's an
> amazingly complex driver (with support of so many variants).  By
> eliminating verbose commentary, it's also wiping away a lot of
> knowledge.  The more sparse commentary makes things harder to
> understand for newcomers, or really anybody who isn't already steeped
> in knowledge about the SSI port and linux, and it's interaction with
> DMA.

This is exactly why I wrote the comments the way I did.  As I was 
learning about the hardware and ASoC drivers, whenever I was confused 
about something and then figured it out, I would add a comment about 
that.  I figured if it wasn't obvious to me, it wouldn't be obvious to 
anyone else.  And since this was one of the first ASoC drivers, and the 
first to use device tree, it would become a reference driver for years 
to come.  That made it even more important that I document everything I 
learned.

I am pleased that other developers kept up that commenting style.  This 
patch destroys all of that.
