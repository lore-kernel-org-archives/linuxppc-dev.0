Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKYLw711YzF0cv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 10:57:28 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id e3so7249836pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 15:57:28 -0800 (PST)
Date: Sun, 14 Jan 2018 15:57:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v2 03/16] ASoC: fsl_ssi: Maintain a mask of active streams
Message-ID: <20180114235720.GA2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
 <1488354c-99b0-fa64-a88c-0fa065df4b7d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488354c-99b0-fa64-a88c-0fa065df4b7d@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 14, 2018 at 11:34:01PM +0100, Maciej S. Szmigiero wrote:

> > +	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
> Using a bool variable for a bit index (and array index in other parts
> of code) looks just wrong.
> 
> Even a simple int would look better IMHO here (and in patch 5 that
> rewrites this line a bit).

Will change to int. Thanks
