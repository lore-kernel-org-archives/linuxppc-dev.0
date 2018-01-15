Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL6GP1ysxzF0Xw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 08:40:28 +1100 (AEDT)
Received: by mail-pg0-x22e.google.com with SMTP id c194so8490477pga.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 13:40:28 -0800 (PST)
Date: Mon, 15 Jan 2018 13:40:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v3 14/17] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
Message-ID: <20180115214021.GB10868@Asurada>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
 <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2018 at 10:16:28PM +0100, Maciej S. Szmigiero wrote:

> > * Removing TXBIT0 configurations since this bit is set to 1 as its
> >   reset value and there is no use case so far to unset it. And it
> >   is safe to remove since regmap_update_bits() won't touch it.
> 
> I didn't get any response to a comment I've written about the point

I neglected the comments in the middle. Sorry. Will add it back then.
