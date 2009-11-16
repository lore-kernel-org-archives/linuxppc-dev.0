Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id E293DB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 Nov 2009 19:14:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Mon, 16 Nov 2009 09:09:08 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
In-Reply-To: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200911160909.08433.arnd@arndb.de>
Cc: Alon Ziv <alonz@discretix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 15 November 2009, Alon Ziv wrote:
> *)PORT_16450, },
> -       { .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
> +       { .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550A, },

Does not seem logical. If the device claims compatibility with ns16550, we should
not automatically assume it's an ns16550a. Why not add another line for 

{ .type = "serial", .compatible = "ns16550a",  .data = (void *)PORT_16550A, },

	Arnd <><
