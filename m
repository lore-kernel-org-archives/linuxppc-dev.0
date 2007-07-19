Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26FFFDE016
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:36:31 +1000 (EST)
Message-ID: <469F9301.6080402@freescale.com>
Date: Thu, 19 Jul 2007 11:36:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013611.GY15238@ld0162-tx32.am.freescale.net>
	<20070718032857.GF18251@localhost.localdomain>
	<F5E8139F-E8DA-4C41-8B90-E727FD4E346C@kernel.crashing.org>
	<469E7350.3090308@freescale.com>
	<97B4A805-6E2A-4F8E-BC56-5BDEE8D6F5F0@kernel.crashing.org>
In-Reply-To: <97B4A805-6E2A-4F8E-BC56-5BDEE8D6F5F0@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Can you dump the POCMRx registers and report their values and what / 
> proc/iomem looks like.

POTAR0: 0x00080000
POTAR1: 0x000a0000
POTAR2: 0x00000000

POBAR0: 0x00080000
POBAR1: 0x000a0000
POBAR2: 0x000f6000

POCMR0: 0xa00e0000
POCMR1: 0x800e0000
POCMR2: 0xc00fe000

PITAR0: 0x00000000
PIBAR0: 0x00000000
PICMR0: 0xa00fc000

-sh-2.05b# cat /proc/iomem
80000000-9fffffff : /soc@f0000000/pci@10800
a0000000-bfffffff : /soc@f0000000/pci@10800
   a0000000-a001ffff : 0000:00:17.0
     a0000000-a001ffff : e1000
   a0020000-a003ffff : 0000:00:17.0
     a0020000-a003ffff : e1000

-Scott
