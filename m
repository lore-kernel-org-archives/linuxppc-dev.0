Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CBEB5B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 05:07:18 +1100 (EST)
Subject: Re: [PATCH] mcu_mpc8349emitx.c: add shutdown request support
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1313417970-28098-1-git-send-email-fabio.baltieri@gmail.com>
Date: Thu, 3 Nov 2011 13:07:10 -0500
Message-Id: <3051811F-3000-44B1-B207-01D654E453E3@kernel.crashing.org>
References: <1313417970-28098-1-git-send-email-fabio.baltieri@gmail.com>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2011, at 9:19 AM, Fabio Baltieri wrote:

> This patch add support for calling ctrl_alt_del() when the power =
button is
> pressed for more than about 2 seconds on some freescale MPC83xx
> evaluation boards and reference design.
>=20
> The code uses a kthread to poll the CTRL_BTN bit each second.
>=20
> Also change Kconfig entry of the driver to bool, as device's gpio
> registration is broken when loading as module.
>=20
> Tested on an MPC8315E RDB board.
>=20
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   58 =
+++++++++++++++++++++++-
> arch/powerpc/platforms/Kconfig                 |    2 +-
> 2 files changed, 58 insertions(+), 2 deletions(-)

applied

- k=
