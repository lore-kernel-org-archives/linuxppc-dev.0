Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 935FBB70A9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 16:59:55 +1100 (EST)
Subject: Re: [PATCH 1/2] [v2] powerpc: export ppc_proc_freq and ppc_tb_freq as
	GPL symbols
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284999822-24753-1-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 00:59:49 -0500
Message-ID: <5B523788-3623-402C-A3A2-990F59ED4348@freescale.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
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

> Export the global variable 'ppc_tb_freq', so that modules (like the =
Book-E
> watchdog driver) can use it.  To maintain consistency, ppc_proc_freq =
is changed
> to a GPL-only export.  This is okay, because any module that needs =
this symbol
> should be an actual Linux driver, which must be GPL-licensed.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This export is necessary for the Book-E watchdog driver to be compiled =
as a
> module.
>=20
> arch/powerpc/kernel/time.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)

applied to next

- k=
