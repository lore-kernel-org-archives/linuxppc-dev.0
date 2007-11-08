Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDFF2DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:33:30 +1100 (EST)
Date: Thu, 8 Nov 2007 14:33:23 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
Message-Id: <20071108143323.85e8e1e3.kim.phillips@freescale.com>
In-Reply-To: <F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
	<F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Nov 2007 13:57:59 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Nov 8, 2007, at 1:37 PM, Kim Phillips wrote:
> 
> > Now the rtc class ds1374 driver has been added,
> > remove the old rtc driver hookup code, add rtc node
> > to device trees, and turn on the new driver in the defconfigs.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc832x_mds.dts      |    7 ++++
> >  arch/powerpc/boot/dts/mpc834x_mds.dts      |    9 +++++
> >  arch/powerpc/boot/dts/mpc836x_mds.dts      |    9 +++++
> >  arch/powerpc/configs/mpc832x_mds_defconfig |   48 +++++++++++++++++ 
> > ++++++++++-
> >  arch/powerpc/configs/mpc834x_mds_defconfig |   48 +++++++++++++++++ 
> > ++++++++++-
> >  arch/powerpc/configs/mpc836x_mds_defconfig |   48 +++++++++++++++++ 
> > ++++++++++-
> >  arch/powerpc/configs/mpc8568mds_defconfig  |   48 +++++++++++++++++ 
> > ++++++++++-
> >  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 --------------
> >  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 --------------
> >  arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 --------------
> >  10 files changed, 213 insertions(+), 76 deletions(-)
> 
> should the mpc8568mds.dts be updated?

it already has the rtc node.

> Also, what code is parsing the device tree for the rtc node?
> 
the i2c code in fsl_soc.c.

Kim
