Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3053DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 20:38:32 +1100 (EST)
Message-ID: <49C3640D.5040008@gefanuc.com>
Date: Fri, 20 Mar 2009 09:38:21 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/4] powerpc/86xx: Move gianfar mdio nodes under
	the	ethernet nodes
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
	<20090319180151.GD6114@oksana.dev.rtsoft.ru>
In-Reply-To: <20090319180151.GD6114@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Currently it doesn't matter where the mdio nodes are placed, but with
> power management support (i.e. when sleep = <> properties will take
> effect), mdio nodes placement will become important: mdio controller
> is a part of the ethernet block, so the mdio nodes should be placed
> correctly. Otherwise we may wrongly assume that MDIO controllers are
> available during sleep.
> 
> Suggested-by: Scott Wood <scottwood@freescale.com>
> Suggested-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/gef_ppc9a.dts        |   39 ++++---
>  arch/powerpc/boot/dts/gef_sbc310.dts       |   39 ++++---
>  arch/powerpc/boot/dts/gef_sbc610.dts       |   39 ++++---
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  157 +++++++++++++++-------------
>  arch/powerpc/boot/dts/sbc8641d.dts         |  156 +++++++++++++++-------------
>  arch/powerpc/platforms/86xx/gef_ppc9a.c    |    1 +
>  arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 +
>  arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 +
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 +
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
>  arch/powerpc/platforms/86xx/sbc8641d.c     |    1 +
>  11 files changed, 237 insertions(+), 199 deletions(-)
> 

Tested on ppc9a. Other GE Fanuc boards look sane.

Tested-by: Martyn Welch <martyn.welch@gefanuc.com>

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
