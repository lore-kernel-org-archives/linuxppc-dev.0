Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ykrb638WfzDrTr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 11:36:34 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id m4so7203243pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Nov 2017 16:36:34 -0800 (PST)
Date: Sat, 25 Nov 2017 16:36:23 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 caleb@crome.org, max.krummenacher@toradex.com, mpa@pengutronix.de,
 mail@maciej.szmigiero.name
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Message-ID: <20171126003622.GA7276@Asurada>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
 <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
 <20170913230147.GA21287@Asurada-Nvidia>
 <20171125232921.01994d72@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171125232921.01994d72@jawa>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 25, 2017 at 11:29:48PM +0100, Lukasz Majewski wrote:

> Nicolin, do you know what happened with this patch? I couldn't find it
> in current linux/master.
> 
> Has it been applied to any asoc tree for being upstreamed?

A similar patch with an updated subject got applied:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20171124&id=b0a7043d5c2ccdd306959f295bf1a62be025cbf5
