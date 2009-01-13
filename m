Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F6A7DE25F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 01:39:50 +1100 (EST)
Message-Id: <D5E479F3-2208-4803-BE83-F22F50247F21@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090111165539.GA27223@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
	drivers/i2c/chips/
Date: Tue, 13 Jan 2009 08:39:37 -0600
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
	<20090111165539.GA27223@oksana.dev.rtsoft.ru>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2009, at 10:55 AM, Anton Vorontsov wrote:

> This patch is used to help Jean Delvare to get rid of drivers/i2c/ 
> chips/
> directory. The new location suggested by Kumar Gala: as the driver is
> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> The same patch but suitable for patch(1).
>
> arch/powerpc/platforms/83xx/Makefile           |    1 +
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  209 +++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/Kconfig                 |   11 ++
> drivers/i2c/chips/Kconfig                      |   11 --
> drivers/i2c/chips/Makefile                     |    1 -
> drivers/i2c/chips/mcu_mpc8349emitx.c           |  209  
> ------------------------
> 6 files changed, 221 insertions(+), 221 deletions(-)
> create mode 100644 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> delete mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

applied

- k
