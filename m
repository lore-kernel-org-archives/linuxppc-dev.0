Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8DBEEDDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:00:11 +1100 (EST)
Date: Thu, 20 Dec 2007 00:02:22 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
Message-ID: <20071219210222.GA21147@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
	<6B8F6F4B-1FD2-4A11-B4F6-A1A0ECD7342B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <6B8F6F4B-1FD2-4A11-B4F6-A1A0ECD7342B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 02:54:09PM -0600, Kumar Gala wrote:
> 
> On Dec 19, 2007, at 2:38 PM, Anton Vorontsov wrote:
> 
> >Also rename "fsl_spi" to "fsl,spi".
> >
> >Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> >arch/powerpc/boot/dts/mpc8313erdb.dts    |    3 +--
> >arch/powerpc/boot/dts/mpc832x_mds.dts    |    6 ++----
> >arch/powerpc/boot/dts/mpc832x_rdb.dts    |    6 ++----
> >arch/powerpc/boot/dts/mpc8349emitx.dts   |    3 +--
> >arch/powerpc/boot/dts/mpc8349emitxgp.dts |    3 +--
> >arch/powerpc/boot/dts/mpc834x_mds.dts    |    3 +--
> >arch/powerpc/boot/dts/mpc836x_mds.dts    |    6 ++----
> >arch/powerpc/boot/dts/mpc8568mds.dts     |    6 ++----
> >arch/powerpc/sysdev/fsl_soc.c            |    2 +-
> >9 files changed, 13 insertions(+), 25 deletions(-)
> 
> 
> can you add cell-index as well.

Sure. Will do tomorrow since here is night already. ;-)

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
