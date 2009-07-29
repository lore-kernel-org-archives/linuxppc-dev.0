Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8F4AEB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 23:40:39 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E32C2DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 23:40:38 +1000 (EST)
Message-Id: <820BFB98-F940-4B5C-8D4A-9C069B3DC199@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4A70091E.7000002@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: 82xx, mgcoge: updates for 2.6.32
Date: Wed, 29 Jul 2009 08:40:29 -0500
References: <4A70091E.7000002@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 29, 2009, at 3:32 AM, Heiko Schocher wrote:

> - add I2C support
> - add FCC1 and FCC2 support
> - fix bogus gpio numbering in plattformcode
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> - based on git://git.kernel.org/pub/scm/linux/kernel/git/benh/ 
> powerpc.git
>  next branch
> - checked with checkpatch.pl:
> $ ./scripts/checkpatch.pl 0001-82xx-mgcoge-updates-for-2.6.32.patch
> total: 0 errors, 0 warnings, 531 lines checked
>
> 0001-82xx-mgcoge-updates-for-2.6.32.patch has no obvious style  
> problems and is ready for submission.
> $
>
> BTW: Who is PPC82XX Maintainer? I couldn;t find such an entry
>     in the MAINTAINERS file ...

its me.

> arch/powerpc/boot/dts/mgcoge.dts      |   56 ++++++++++
> arch/powerpc/configs/mgcoge_defconfig |  178 ++++++++++++++++++++++++ 
> +-------

Can we hold off or pull the defconfig update into a separate patch.  I  
normally update defconfigs in a late -rc series and that will probably  
generate merge conflicts.

>
> arch/powerpc/platforms/82xx/mgcoge.c  |   69 +++++++++++--
> 3 files changed, 255 insertions(+), 48 deletions(-)

- k
