Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 521F4DE38A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 02:09:18 +1000 (EST)
Message-ID: <469B9825.6070507@freescale.com>
Date: Mon, 16 Jul 2007 11:09:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: Linuxppc-embedded Digest, Vol 35, Issue 33
References: <mailman.1061.1184600645.8639.linuxppc-embedded@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D78D7DE9@corpexc01.corp.networkrobots.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: sureshtang@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Siva Prasad wrote:
> It returns kernel virtual address. If you use this buffer space for DMA,
> please use appropriate flags. You may use __pa(address) or
> virt_to_phys() to convert virtual to physical.

No, you may not -- physical and DMA addresses are not always identical. 
  Use the DMA mapping API.

-Scott
