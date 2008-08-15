Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B270CDDFE2
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 08:00:06 +1000 (EST)
Message-Id: <87674E2E-05CB-41E8-A1C9-EC54D27798AD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4858C988.1000405@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based
	board	MGCOGE from keymile.
Date: Fri, 15 Aug 2008 16:59:58 -0500
References: <20080612153215.GB2756@loki.buserror.net>
	<4852A144.6090204@denx.de> <20080616072625.GB28470@yookeroo.seuss>
	<4856350E.4080602@denx.de>
	<20080616164915.GA14020@loki.buserror.net>
	<4858C988.1000405@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 3:38 AM, Heiko Schocher wrote:

> Hello,
>
> changes since the last patch:
>
> update the Portpin initialization.
>
> [powerpc]  Added support for the MPC8247 based board MGCOGE
>           from Keymile.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
> arch/powerpc/configs/mgcoge_defconfig |  900 ++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/82xx/Kconfig   |    8 +
> arch/powerpc/platforms/82xx/Makefile  |    1 +
> arch/powerpc/platforms/82xx/mgcoge.c  |  129 +++++
> 5 files changed, 1212 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
> create mode 100644 arch/powerpc/configs/mgcoge_defconfig
> create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c

This fails to compile for with 2.6.27-rc3:

drivers/net/fs_enet/mac-scc.c: In function 'restart':
drivers/net/fs_enet/mac-scc.c:256: error: implicit declaration of  
function '__fs_out8'
drivers/net/fs_enet/mac-scc.c:265: error: 'SCC_EB' undeclared (first  
use in this function)
drivers/net/fs_enet/mac-scc.c:265: error: (Each undeclared identifier  
is reported only once
drivers/net/fs_enet/mac-scc.c:265: error: for each function it appears  
in.)
make[3]: *** [drivers/net/fs_enet/mac-scc.o] Error 1
make[2]: *** [drivers/net/fs_enet] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


- k
