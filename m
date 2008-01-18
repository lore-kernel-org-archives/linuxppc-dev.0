Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74183DE15F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:49:42 +1100 (EST)
Date: Fri, 18 Jan 2008 00:47:17 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] [SERIAL] qe-uart: add support for Freescale QUICCEngine
	UART
In-Reply-To: <12004125733910-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0801180047020.16260@blarg.am.freescale.net>
References: <12004125733910-git-send-email-timur@freescale.com>
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

On Tue, 15 Jan 2008, Timur Tabi wrote:

> Add file ucc_uart.c, a serial device driver for the Freescale QUICCEngine.
> Update the Kconfig and Makefile accordingly.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updated to reflect comments from Kumar.
>
>  drivers/serial/Kconfig    |   10 +
>  drivers/serial/Makefile   |    1 +
>  drivers/serial/ucc_uart.c | 1514 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1525 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/serial/ucc_uart.c
>

applied.

- k
