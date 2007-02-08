Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id D3A3CDDF1B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 07:43:14 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Celleb: improve htab lock
Date: Thu, 8 Feb 2007 21:43:09 +0100
References: <200702080618.l186InGM014774@toshiba.co.jp>
	<200702080751.45278.arnd@arndb.de> <20070208202802.GA2579@lst.de>
In-Reply-To: <20070208202802.GA2579@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702082143.10213.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 February 2007 21:28, Christoph Hellwig wrote:
> =A0Also if we're sure that this is
> always called from process context and with irqs enabled we should
> be using local_irq_disable/local_irq_enable and avoid saving the
> flags word.

Right, that's what I meant, I was a little confused here.

	Arnd <><
