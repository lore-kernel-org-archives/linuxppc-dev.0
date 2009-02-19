Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id C822EDDDA9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 17:33:17 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Thu, 19 Feb 2009 17:33:15 +1100
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054A@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the swift response.

> > I also found that both gfar_init (in gianfar.c) and=20
> > gfar_mdio_init (in gianfar_mii.c) are called but the probe=20
> > handlers of either of these devices are not executed.
> > =20
> > What am I missing?

> Don't find any obvious problem.  I suggest you to debug gfar_of_init()
> in arch/powerpc/sysdev/fsl_soc.c to see if it works correctly.

That fn doesn't exist in the dev tree I'm using (commit 103f194f3ccf4684254=
8eb52e607167b6d4951ef)

The driver is now initialised through of_device. I can't figure out how the=
 probe handler is invoked.
