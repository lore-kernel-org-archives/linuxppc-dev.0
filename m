Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxs4D0swszDsG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 09:36:27 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id p84so2190220pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 14:36:27 -0800 (PST)
Date: Wed, 13 Dec 2017 14:36:24 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: Re: [PATCH v2 03/11] ASoC: fsl_ssi: Refine all comments
Message-ID: <20171213223623.GB13576@Asurada-Nvidia>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-4-git-send-email-nicoleotsuka@gmail.com>
 <e264f260-c8df-a51a-4756-cf2ebf979c66@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e264f260-c8df-a51a-4756-cf2ebf979c66@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 13, 2017 at 11:28:51PM +0100, Maciej S. Szmigiero wrote:

> > -	/*
> > -	 * If we're in synchronous mode, and the SSI is already enabled,
> > -	 * then STCCR is already set properly.
> > -	 */
> > +	/* To support simultaneous TX and RX, bypass it if SSI is enabled */
> >  	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
> >  		return 0;
> >  
> 
> I would say that the old comment described better what is happening -
> since in synchronous (& non-AC'97) mode STCCR controls both TX and RX
> the first direction that is started (either playback or capture) is the
> only direction that needs to configure SSI in hw_params().

There is also an SCR register configuration in this hw_params(),
so the old comment has to be updated. But I would take it into
consideration and revise a bit.

Thanks.
