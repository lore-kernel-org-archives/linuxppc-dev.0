Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2E73DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:53:12 +1100 (EST)
Date: Fri, 18 Jan 2008 00:50:48 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v3 1/8] Add IPIC config option
In-Reply-To: <1200614738-25654-2-git-send-email-jrigby@freescale.com>
Message-ID: <Pine.LNX.4.64.0801180050350.16433@blarg.am.freescale.net>
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
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

On Thu, 17 Jan 2008, John Rigby wrote:

> IPIC is not just for 83xx anymore so make it a separate
> config option.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/platforms/Kconfig |    5 +++++
>  arch/powerpc/sysdev/Makefile   |    2 +-
>  2 files changed, 6 insertions(+), 1 deletions(-)

applied.

- k
