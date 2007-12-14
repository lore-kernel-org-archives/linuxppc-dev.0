Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 84DEEDE0A6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 08:41:17 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/4] Freescale enhanced Local Bus Controller FCM NAND
	support.
Date: Fri, 14 Dec 2007 22:40:48 +0100
References: <20071214185624.GA10584@loki.buserror.net>
	<4762DA95.90000@freescale.com>
	<20071214195917.GA18616@localhost.localdomain>
In-Reply-To: <20071214195917.GA18616@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712142240.50379.arnd@arndb.de>
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 14 December 2007, Anton Vorontsov wrote:
> > >Maybe this desires its own header?
> > 
> > It can be factored out if anything else ever uses it.
> 
> It's just confusing to parse lbc-specific and nand-specific code
> placed in the same file.

In that case, you could argue for splitting the implementation into
two C files. I don't see any reason to move stuff into a header
when it's not an interface between two parts of the code, but
only describes a hardware interface used by a single driver.

	Arnd <><
