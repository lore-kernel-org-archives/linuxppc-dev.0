Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41098B7D19
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 06:41:39 +1100 (EST)
Subject: Re: GE GPIO and PIC support.
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B548A6A.5010708@ge.com>
Date: Mon, 18 Jan 2010 13:41:26 -0600
Message-Id: <633A9DB6-1D25-4D2B-BD2A-7ED638E267C5@kernel.crashing.org>
References: <4B548A6A.5010708@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2010, at 10:20 AM, Martyn Welch wrote:

> Hi,
>=20
> I'm currently adding support for a GE board based on the Freescale
> P2020. This board has a cascaded interrupt controller and GPIO which
> should be compatible with drivers currently provided for the MPC8641D
> based boards that are already in the kernel.
>=20
> At the moment the drivers (in gef_gpio.c and gef_pic.c) are in the
> "arch/powerpc/platforms/86xx" folder. As the p2020 is not 86xx, I =
guess
> I should move these drivers to a more central location. I'm currently
> not sure where would be best to move them to, I see
> "arch/powerpc/sysdev" and "arch/powerpc/platforms" as potential
> locations, where would be the most suitable?

I would suggest arch/powerpc/platforms as its board specific code and =
not chip specific.  However others gripe at me about that from time to =
time.

- k=
