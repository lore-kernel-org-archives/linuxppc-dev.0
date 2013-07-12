Return-Path: <timur@tabi.org>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
 by ozlabs.org (Postfix) with SMTP id E0DC62C0345
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:13:37 +1000 (EST)
Message-ID: <51DF826C.40208@tabi.org>
Date: Thu, 11 Jul 2013 23:13:32 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE
 are both cleared
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712040930.GB27823@MrMyself>
In-Reply-To: <20130712040930.GB27823@MrMyself>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 shawn.guo@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
> Oh, I see. Actually we've been using this patch for quite a while,
> it should be okay.

Have you tested it on PowerPC?

-- 
Timur Tabi
