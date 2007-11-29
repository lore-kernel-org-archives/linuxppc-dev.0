Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 10A75DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 08:30:13 +1100 (EST)
Date: 29 Nov 2007 14:30:11 -0700
Message-ID: <20071129213011.17261.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: gorcunov@gmail.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] PPC cleanup: sysdev - do use for_each macro
In-Reply-To: <20071129194436.GB12123@cvg>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
> 
>  arch/powerpc/sysdev/fsl_soc.c      |    7 +++----
>  arch/powerpc/sysdev/mv64x60_dev.c  |   24 ++++++++++--------------
>  arch/powerpc/sysdev/mv64x60_pci.c  |    4 ++--
>  arch/powerpc/sysdev/mv64x60_udbg.c |    4 ++--
>  arch/powerpc/sysdev/tsi108_dev.c   |    9 ++++-----
>  arch/powerpc/sysdev/uic.c          |   17 +++++------------
>  6 files changed, 26 insertions(+), 39 deletions(-)

Ack of the mv64x60 bits.

-Dale
