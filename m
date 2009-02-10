Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C841DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 03:10:11 +1100 (EST)
Date: Tue, 10 Feb 2009 17:10:00 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C   to complete
Message-ID: <20090210171000.1f45cc2d@hyperion.delvare>
In-Reply-To: <4991A4F2.8030506@freescale.com>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
	<20090210165554.0da8bf7c@hyperion.delvare>
	<4991A4F2.8030506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Feb 2009 10:01:54 -0600, Timur Tabi wrote:
> Jean Delvare wrote:
>=20
> > No, that's something for either Ben Dooks (Cc'd) or the powerpc tree.
>=20
> This patch has nothing to do with ARM, so Kumar will pick it up, if you
> ACK it.

Why are you mentioning ARM?

=46rom MAINTAINERS:

I2C SUBSYSTEM
P:      Jean Delvare (PC drivers, core)
M:      khali@linux-fr.org
P:      Ben Dooks (embedded platforms)
M:      ben-linux@fluff.org

To the best of my knowledge i2c-mpc falls into the "embedded platforms"
category and is thus under Ben's responsibility.

Thanks,
--=20
Jean Delvare
