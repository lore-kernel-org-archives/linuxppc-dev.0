Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CF06ADDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 16:12:20 +1000 (EST)
Message-ID: <48A674BA.3060509@denx.de>
Date: Sat, 16 Aug 2008 08:33:30 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based board	MGCOGE
	from keymile.
References: <20080612153215.GB2756@loki.buserror.net>
	<4852A144.6090204@denx.de> <20080616072625.GB28470@yookeroo.seuss>
	<4856350E.4080602@denx.de>
	<20080616164915.GA14020@loki.buserror.net>
	<4858C988.1000405@denx.de>
	<87674E2E-05CB-41E8-A1C9-EC54D27798AD@kernel.crashing.org>
In-Reply-To: <87674E2E-05CB-41E8-A1C9-EC54D27798AD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

Kumar Gala schrieb:
> On Jun 18, 2008, at 3:38 AM, Heiko Schocher wrote:
>> changes since the last patch:
>>
>> update the Portpin initialization.
>>
>> [powerpc]  Added support for the MPC8247 based board MGCOGE
>>           from Keymile.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
>> arch/powerpc/configs/mgcoge_defconfig |  900
>> +++++++++++++++++++++++++++++++++
>> arch/powerpc/platforms/82xx/Kconfig   |    8 +
>> arch/powerpc/platforms/82xx/Makefile  |    1 +
>> arch/powerpc/platforms/82xx/mgcoge.c  |  129 +++++
>> 5 files changed, 1212 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
>> create mode 100644 arch/powerpc/configs/mgcoge_defconfig
>> create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c
> 
> This fails to compile for with 2.6.27-rc3:
> 
> drivers/net/fs_enet/mac-scc.c: In function 'restart':
> drivers/net/fs_enet/mac-scc.c:256: error: implicit declaration of
> function '__fs_out8'
> drivers/net/fs_enet/mac-scc.c:265: error: 'SCC_EB' undeclared (first use
> in this function)
> drivers/net/fs_enet/mac-scc.c:265: error: (Each undeclared identifier is
> reported only once
> drivers/net/fs_enet/mac-scc.c:265: error: for each function it appears in.)
> make[3]: *** [drivers/net/fs_enet/mac-scc.o] Error 1
> make[2]: *** [drivers/net/fs_enet] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....

:-(

So in 2.6.27-rc3 lacks another patch from me :-( , see:

http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057824.html

and I posted this patch First time in January 2008!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
