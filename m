Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2754DDF85
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 04:45:48 +1000 (EST)
Subject: RE: [PATCH] ibm_newemac: Add support for GPCS, SGMII andM88E1112PHY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Gallardo <vgallardo@amcc.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D6050D1492@SDCEXCHANGE01.ad.amcc.com>
References: <0CA0A16855646F4FA96D25A158E299D6050D1492@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Thu, 18 Sep 2008 11:42:14 -0700
Message-Id: <1221763334.7892.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-18 at 11:39 -0700, Victor Gallardo wrote:
> Hi Ben,
> 
> Any update on this patch? I need this patch to support our upcoming AMCC Arches evaluation board.

I'm currently travelling & attending the Linux Plumbers conference in
Portland. I'll look at the patch again next week. It's definitely on my
queue of things that should be merged in .28 after I verify it doesn't
break anything.

Cheers,
Ben.

> >Hi Ben,
> >
> >>Ok. Thanks. I need to review your patch a bit better, hopefully later 
> >>this week. I'll let you know. Ping me if you get no news by next monday.
> >>
> >>Cheers,
> >Ben.
> >
> >Have you had a change to look at this patch?
> >
> 
> Regards,
> 
> Victor Gallardo
