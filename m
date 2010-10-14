Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 686891007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 17:08:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: change the Book-E watchdog driver default
	timeout into a Kconfig option
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1286997576-4988-1-git-send-email-timur@freescale.com>
Date: Thu, 14 Oct 2010 01:08:16 -0500
Message-ID: <6354FDA6-BAEC-48DB-BAA8-D5ED2506B17D@freescale.com>
References: <1286997576-4988-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 2:19 PM, Timur Tabi wrote:

> The PowerPC Book-E watchdog driver (booke_wdt.c) defines a default =
timeout
> value in the code based on whether it's a Freescale Book-E part of =
not.
> Instead of having hard-coded values in the driver, make it a Kconfig =
option.
>=20
> As newer chips gets faster, the current default values become less =
appropriate,
> since the timeout sometimes occurs before the kernel finishes booting. =
 Making
> the value a Kconfig option allows BSPs to configure a new value with =
requiring
> the wdt_period command-line parameter to be set.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/watchdog/Kconfig     |   17 +++++++++++++++++
> drivers/watchdog/booke_wdt.c |    8 +-------
> 2 files changed, 18 insertions(+), 7 deletions(-)

applied to next, fixed commit message.

Also, in general I believe commit messages should be about 75 columns so =
they dont wrap if you do a git log in an 80 column terminal.

- k=
