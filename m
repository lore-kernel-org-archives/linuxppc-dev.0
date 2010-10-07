Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7245AB70CD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:04:39 +1100 (EST)
Subject: Re: [PATCH 2/2] [v2] powerpc/watchdog: allow the e500 watchdog driver
	to be compiled as a module
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284999822-24753-2-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 01:00:21 -0500
Message-ID: <895E8A3E-55AB-4F08-91B7-4C83F838D6E7@freescale.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
	<1284999822-24753-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 20, 2010, at 11:23 AM, Timur Tabi wrote:

> Register the __init and __exit functions in the PowerPC e500 watchdog =
driver
> as module entry/exit functions, and modify the Kconfig entry.
>=20
> Add a .release method for the PowerPC e500 watchdog driver, so that =
the
> watchdog is disabled when the driver is closed.
>=20
> Loosely based on original code from Jiang Yutang =
<b14898@freescale.com>.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This patch requires:
>=20
> 	powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols
>=20
> drivers/watchdog/Kconfig     |    5 ++++-
> drivers/watchdog/booke_wdt.c |   39 =
+++++++++++++++++++++++++++++++++++++--
> 2 files changed, 41 insertions(+), 3 deletions(-)


applied to next [fixed comment message to say Book-E instead of e500]

- k=
