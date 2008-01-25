Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 021C8DE0BA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 02:59:35 +1100 (EST)
Date: Fri, 25 Jan 2008 09:57:04 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] mpc834x_mds: Convert device tree source to dts-v1
In-Reply-To: <1201242129-13417-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <Pine.LNX.4.64.0801250956380.16736@blarg.am.freescale.net>
References: <1201242129-13417-1-git-send-email-paul.gortmaker@windriver.com>
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

On Fri, 25 Jan 2008, Paul Gortmaker wrote:

> Move mpc834x_mds device tree source forward to dts-v1 format.  Nothing
> too complex in this one, so it boils down to just adding a bunch of 0x
> in the right places and converting clock speeds to decimal.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/mpc834x_mds.dts |  254 +++++++++++++++++----------------
>  1 files changed, 128 insertions(+), 126 deletions(-)
>

applied.  I fixed up things so that interrupts use decimal.

- k
