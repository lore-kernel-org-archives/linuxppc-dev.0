Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BE7CDE561
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:50:02 +1100 (EST)
Date: Fri, 18 Jan 2008 00:47:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] qe: add support for Freescale QUICCEngine UART
In-Reply-To: <11999217072674-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0801180047260.16260@blarg.am.freescale.net>
References: <11999217062265-git-send-email-timur@freescale.com>
	<11999217072674-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2008, Timur Tabi wrote:

> Add support for UART serial ports using a Freescale QUICCEngine. Update
> booting-without-of.txt to define new properties for a QE UART node.  Update
> the MPC8323E-MDS device tree to add UCC5 as a UART.  Update the QE library
> to support slow UCC devices and modules.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    9 ++++-
>  arch/powerpc/boot/dts/mpc832x_mds.dts        |   50 ++++++++++++++++++++++++++
>  arch/powerpc/sysdev/qe_lib/Kconfig           |    2 +-
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c        |   10 +++++-
>  4 files changed, 68 insertions(+), 3 deletions(-)
>

applied.

- k
