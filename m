Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 591DEDDDEC
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 18:38:49 +1100 (EST)
Date: Thu, 16 Oct 2008 10:38:36 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: powerpc allmodconfig
Message-ID: <20081016073836.GB23630@cs181140183.pp.htv.fi>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<s5h1vyhrsja.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <s5h1vyhrsja.wl%tiwai@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, marek.vasut@gmail.com,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Mark Fasheh <mark.fasheh@oracle.com>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2008 at 07:57:29AM +0200, Takashi Iwai wrote:
> At Wed, 15 Oct 2008 21:33:37 -0700,
> Andrew Morton wrote:
> > 
> > sound/soc/soc-dapm.c:1029: warning: 'snd_soc_dapm_connect_input' is deprecated (declared at sound/soc/soc-dapm.c:1026)
> > sound/soc/soc-dapm.c:1029: warning: 'snd_soc_dapm_connect_input' is deprecated (declared at sound/soc/soc-dapm.c:1026)
> 
> These are definitions of deprecated interfaces.
> We can remove it in 2.6.29.  If we don't want to be conservative, it
> can be removed in 2.6.28, too.
>...

Since it's an in-kernel API there's no reason to keep it once there are 
no users left.

But currently sound/soc/at32/playpaq_wm8510.c still seems to use it.

> thanks,
> 
> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
