Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 61AB0B7CA4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 06:21:21 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC46EDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 06:21:20 +1000 (EST)
Message-Id: <1728A81B-6BC8-4FF0-AF58-101CBA264517@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <764194b0524e1baccb737668f5aeb198989ac2d1.1250036189.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 3/4] Fix incorrect PCI interrupt map in SBC834x DTS
Date: Fri, 14 Aug 2009 15:21:16 -0500
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
	<22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
	<764194b0524e1baccb737668f5aeb198989ac2d1.1250036189.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 8:34 AM, Paul Gortmaker wrote:

> From: Liang Li <liang.li@windriver.com>
>
> Allows interrupts to occur on the sbc834x. Currently PCI devices
> get assigned an incorrect IRQ and so the interrupt count never
> increases. This was tested with the 82546GB based dual port E1000
> PCI-X NIC which uses two distinct IRQ lines on the one card.
>
> root@localhost:/root> cat /proc/interrupts | grep eth
> 17:         78   IPIC   Level     eth1
> 48:      27121   IPIC   Level     eth0
>
> Signed-off-by: Liang Li <liang.li@windriver.com>
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8349.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)


applied to next

- k
