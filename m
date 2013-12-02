Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 646BE2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 02:24:26 +1100 (EST)
Date: Mon, 2 Dec 2013 23:21:31 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Message-ID: <20131202152130.GB8609@MrMyself>
References: <1384532729-6588-1-git-send-email-b42378@freescale.com>
 <20131202115617.GV27568@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131202115617.GV27568@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, timur@tabi.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 02, 2013 at 11:56:17AM +0000, Mark Brown wrote:
> On Sat, Nov 16, 2013 at 12:25:29AM +0800, Nicolin Chen wrote:
> > The normal mode of SSI allows it to send/receive data to/from the first
> > slot of each period. So we can use this normal mode to trick I2S signal
> > by puting/getting data to/from the first slot only (the left channel)
> > so as to support monaural audio playback and recording.
> 
> This looks OK but doesn't apply against current code, can you please
> check and resend?

Ah, I rebased it on the dual-fifo set. Sorry I didn't make it clean.
I will resend it. Thank you.
