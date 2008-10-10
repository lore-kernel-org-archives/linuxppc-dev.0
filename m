Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17409DE10D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:27:47 +1100 (EST)
Message-Id: <C7F66E2A-0338-41B4-9636-2E6FFBED6B19@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
Date: Fri, 10 Oct 2008 09:18:38 -0500
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 9:12 AM, Anton Vorontsov wrote:

> of/base.c matches on the first (most specific) entries, which isn't
> quite practical but it was discussed[1] that this won't change.
>
> The bindings specifies verbose information for the devices, but
> it doesn't fit in the I2C ID's 20 characters limit. The limit won't
> change[2], and the bindings won't change either as they're correct.
>
> So we have to put an exception for the MPC8349E-mITX-compatible
> MCUs.
>
> [1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html
> [2] http://www.nabble.com/-PATCH-1-2--i2c:-expand-I2C's-id.name-to-23-characters-td19577063.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/of/base.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied.

- k
