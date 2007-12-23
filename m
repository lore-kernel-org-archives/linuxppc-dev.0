Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31B93DDDEE
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 14:24:16 +1100 (EST)
Message-ID: <476DD4C4.5030708@freescale.com>
Date: Sat, 22 Dec 2007 21:23:48 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<s5h4ped4gl3.wl%tiwai@suse.de>
	<75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
In-Reply-To: <75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lee Revell wrote:

> Please use DMA_32BIT_MASK (see include/linux/dma-mapping.h) instead of
> 0xffffffff. 

No prob.  But did you see this comment:

/*
  * NOTE: do not use the below macros in new code and do not add new 
definitions
  * here.
  *
  * Instead, just open-code DMA_BIT_MASK(n) within your driver
  */

So I guess I should use DMA_BIT_MASK(32) instead.

> I've personally fixed a heisenbug in an ALSA driver
> caused by incorrectly typed DMA mask...

Can you explain to me what all of this does?  Is it okay to use a static 
u64 variable?  Why do so many drivers do it that way?  I don't even know 
if 0xFFFFFFFF is the right number for my platform.
