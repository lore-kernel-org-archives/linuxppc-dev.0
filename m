Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A855DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 07:03:45 +1100 (EST)
Message-ID: <472F754C.1090202@freescale.com>
Date: Mon, 05 Nov 2007 13:55:56 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	<472F6D5D.3030804@genesi-usa.com>
	<9e4733910711051151p18311586h133ac70917714466@mail.gmail.com>
In-Reply-To: <9e4733910711051151p18311586h133ac70917714466@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> I can change it to remove fsl5200-clocking if someone can tell me if
> this is only needed on the mpc5200b.

Well, it appears to be needed on the mpc5200 (no 'b')...

> This driver also supports the
> MPC107/Tsi107/MPC8240/MPC8245 and           MPC85xx/MPC8641.

You forgot mpc83xx. :-)

> Do any of
> these other chips need fsl5200-clocking?

None of them have it set in arch/powerpc/boot/dts.

-Scott
