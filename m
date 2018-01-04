Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCJBy5pb9zF0QG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 06:43:54 +1100 (AEDT)
Received: by mail-pl0-x236.google.com with SMTP id g2so1617963pli.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 11:43:54 -0800 (PST)
Date: Thu, 4 Jan 2018 11:44:06 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v1 05/15] ASoC: fsl_ssi: Clean up helper functions of
 trigger()
Message-ID: <20180104194405.GD27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-6-git-send-email-nicoleotsuka@gmail.com>
 <59aa58b7-aeda-ef87-e150-9fec9c6229ae@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59aa58b7-aeda-ef87-e150-9fec9c6229ae@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 01, 2018 at 10:59:30PM +0100, Maciej S. Szmigiero wrote:

> > +static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)

> > +		srcr = vals[tx].srcr;
> > +		stcr = vals[tx].stcr;
> > +		sier = vals[tx].sier;
> 
> Implicit assumption here that RX == 0, TX == 1, as in the 03 patch.

Could replace it with "bool dir" as well. Thanks for the review.
