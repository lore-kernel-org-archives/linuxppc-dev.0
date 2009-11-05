Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D518AB7BA8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:19:56 +1100 (EST)
Subject: Re: [PATCH] powerpc/8xxx: enable IPsec ESP by default on
	mpc83xx/mpc85xx
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012113527.a822b6b4.kim.phillips@freescale.com>
Date: Thu, 5 Nov 2009 08:19:35 -0600
Message-Id: <CD6755A1-1CE0-4EEC-8361-F26B4AFF3128@kernel.crashing.org>
References: <20091012113527.a822b6b4.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2009, at 11:35 AM, Kim Phillips wrote:

>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/mpc83xx_defconfig     |   15 ++++++++-------
> arch/powerpc/configs/mpc85xx_defconfig     |   16 ++++++++--------
> arch/powerpc/configs/mpc85xx_smp_defconfig |   16 ++++++++--------
> 3 files changed, 24 insertions(+), 23 deletions(-)

applied to merge

- k
