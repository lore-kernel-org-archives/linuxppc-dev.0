Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F100BB7217
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 02:53:24 +1100 (EST)
Subject: Re: [PATCH] powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321141830.20271.22.camel@x61.thuisdomein>
Date: Sun, 20 Nov 2011 09:53:16 -0600
Message-Id: <8FD955D3-D7DE-45DF-B9F5-247209532B4B@kernel.crashing.org>
References: <1321141830.20271.22.camel@x61.thuisdomein>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 12, 2011, at 5:50 PM, Paul Bolle wrote:

> The driver for the Freescale P3060 QDS got added by commit 96cc017c5b
> ("[...] Add support for P3060QDS board"). Its Kconfig entry selects
> MPC8xxx_GPIO. But at the time that driver got added MPC8xxx_GPIO was
> already renamed to GPIO_MPC8XXX, by commit c68308dd50c ("gpio: move
> mpc8xxx/512x gpio driver to drivers/gpio").
> 
> So make this driver select GPIO_MPC8XXX.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Bravely untested: I haven't got the hardware nor the PPC toolchain
> needed to build this. And it seems this needs (build) testing anyhow.
> 
> 1) Sent to the people who wrote the two patches mentioned in the commit
> explanation and CC'd the non-authors who signed-off these patches.
> 
> 2) The config tools do not complain about selects that cannot be met
> because they concern a Kconfig symbol that doesn't even exist. Shouldn't
> they be made to complain in that case?
> 
> arch/powerpc/platforms/85xx/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
