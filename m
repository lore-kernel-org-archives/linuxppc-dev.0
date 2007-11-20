Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B27E8DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:53:13 +1100 (EST)
Date: Mon, 19 Nov 2007 23:51:46 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH] PPC: Fix potential NULL dereference
In-Reply-To: <20071115184705.GA7273@cvg>
Message-ID: <Pine.LNX.4.64.0711192351010.1217@blarg.am.freescale.net>
References: <20071115184705.GA7273@cvg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 Nov 2007, Cyrill Gorcunov wrote:

> This patch does fix potential NULL pointer dereference
> that could take place inside of strcmp() if
> of_get_property() call failed.
>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>
>  arch/powerpc/platforms/83xx/usb.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>

CC the linuxppc-dev@ozlabs.org list in the future.

applied.

- k
