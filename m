Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B26F8DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 04:05:52 +1100 (EST)
Message-ID: <476AA0A7.4090002@freescale.com>
Date: Thu, 20 Dec 2007 11:04:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>	<476A7B23.2040905@freescale.com>
	<s5h4ped4gl3.wl%tiwai@suse.de>
In-Reply-To: <s5h4ped4gl3.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Takashi Iwai wrote:

> All?  No, only a few...
> For PCI, usually pci_set_dma_mask() and pci_set_consistent_dma_mask()
> are used, of course.

Hmm, ok I was wrong.  I took this code from the ASoC at91 driver.

Unfortunately, I don't understand what this code is trying to do.  The AT91 
driver isn't documented, so I don't even know if I need it.  Can someone explain 
what all this is?  What's the alternative to using a static global?

-- 
Timur Tabi
Linux kernel developer at Freescale
