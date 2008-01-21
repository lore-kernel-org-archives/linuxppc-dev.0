Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52E84DDE21
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:24:26 +1100 (EST)
Date: Mon, 21 Jan 2008 10:21:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] mpc82xx: Embedded Planet EP8248E support
In-Reply-To: <20080117223205.GB17300@loki.buserror.net>
Message-ID: <Pine.LNX.4.64.0801211020490.14453@blarg.am.freescale.net>
References: <20080117223205.GB17300@loki.buserror.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008, Scott Wood wrote:

> This board is also resold by Freescale under the names
> "QUICCStart MPC8248 Evaluation System" and "CWH-PPC-8248N-VE".
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Removed const/initdata combo, and used simple-bus for probing.
>
> Please apply for 2.6.25.
>
>  arch/powerpc/boot/Makefile             |    3 +-
>  arch/powerpc/boot/dts/ep8248e.dts      |  207 ++++++++
>  arch/powerpc/boot/ep8248e.c            |   55 +++
>  arch/powerpc/boot/wrapper              |    2 +-
>  arch/powerpc/configs/ep8248e_defconfig |  821 ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/82xx/Kconfig    |   13 +
>  arch/powerpc/platforms/82xx/Makefile   |    1 +
>  arch/powerpc/platforms/82xx/ep8248e.c  |  324 +++++++++++++
>  include/asm-powerpc/mpc8260.h          |    1 +
>  9 files changed, 1425 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/ep8248e.dts
>  create mode 100644 arch/powerpc/boot/ep8248e.c
>  create mode 100644 arch/powerpc/configs/ep8248e_defconfig
>  create mode 100644 arch/powerpc/platforms/82xx/ep8248e.c
>

applied.

- k
