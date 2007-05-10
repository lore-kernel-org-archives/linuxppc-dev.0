Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F12CDE393
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:19:49 +1000 (EST)
Date: Thu, 10 May 2007 00:15:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm_uart: cpm_uart_set_termios should take ktermios,
	not termios
In-Reply-To: <20070508171921.GA8941@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0705100015100.27791@localhost.localdomain>
References: <20070508171921.GA8941@ld0162-tx32.am.freescale.net>
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

On Tue, 8 May 2007, Scott Wood wrote:

> This eliminates some warnings.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  drivers/serial/cpm_uart/cpm_uart_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>

applied.

- k
