Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7ADA3DDE2B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:58:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/18] Uartlite: improve in-code comments
Date: Fri, 28 Sep 2007 21:43:16 +0200
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181740.18608.67126.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20070928181740.18608.67126.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709282143.16815.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 September 2007, Grant Likely wrote:
> +/* ---------------------------------------------------------------------
> + * Core UART driver operations
> + */
> +

This is a rather unusual style of commenting. IMHO it would be better if you
left out the ----- line.

	Arnd <><
