Return-Path: <timur@tabi.org>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
 by ozlabs.org (Postfix) with SMTP id 415E42C032D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 14:00:20 +1000 (EST)
Message-ID: <51DF7F4F.90707@tabi.org>
Date: Thu, 11 Jul 2013 23:00:15 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE
 are both cleared
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself>
In-Reply-To: <20130712035732.GA27823@MrMyself>
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
> Hi Timur,
>
> On Thu, Jul 11, 2013 at 12:14:56PM -0500, timur@tabi.org wrote:
>> Don't you need an ACK from the maintainer of the driver before applying
>> it?  I haven't had a chance to test it yet.
> If I'm not missing some part of branch updating, it looks like Mark hasn't
> pushed it to the branch yet.
> Please test it for me. Thank you.

I definitely want to.  Unfortunately, I'm literally in the middle of 
moving into a new house, and so everything is packed up.  I won't be able 
to look at it for another week.


-- 
Timur Tabi
