Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id A1761DDDDC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 08:41:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] mtd: add OF2PDEV convertor for the NDFC driver
Date: Thu, 21 Aug 2008 00:40:58 +0200
References: <20080820205958.GA13371@www.tglx.de>
In-Reply-To: <20080820205958.GA13371@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808210040.58809.arnd@arndb.de>
Cc: linux-mtd@lists.infradead.org, Sebastian Siewior <bigeasy@linutronix.de>,
	tglx@linutronix.de, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 August 2008, Sebastian Siewior wrote:
> I didn't convert the NDFC driver to support OF because there are
> non-OF-aware platforms with the ndfc chip.
> All settings are mandatory except the oob layout.

Are you aware of Sean's patch from
http://patchwork.ozlabs.org/linuxppc/patch?id=20183 ?

What are the other platforms using it?

	Arnd <><
