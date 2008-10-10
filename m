Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA266DE064
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 05:48:47 +1100 (EST)
Message-Id: <7669DEAF-DD9D-42CD-8701-289165E78BBD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] i2c: MPC8349E-mITX Power Management and GPIO expander
	driver
Date: Fri, 10 Oct 2008 13:46:19 -0500
References: <20080923141300.GB31262@oksana.dev.rtsoft.ru>
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


On Sep 23, 2008, at 9:13 AM, Anton Vorontsov wrote:

> On MPC8349E-mITX, MPC8315E-RDB and MPC837x-RDB boards there is a
> Freescale MC9S08QG8 (MCU) chip with the custom firmware
> pre-programmed. The chip is used to power-off the board by the
> software, and to control some GPIO pins.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/i2c/chips/Kconfig            |   11 ++
> drivers/i2c/chips/Makefile           |    1 +
> drivers/i2c/chips/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 221 insertions(+), 0 deletions(-)
> create mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

applied

- k
