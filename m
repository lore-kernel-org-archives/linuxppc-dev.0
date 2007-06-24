Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5E252DDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 06:23:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Mem-2-Mem DMA - Generalized API
Date: Sun, 24 Jun 2007 22:21:57 +0200
References: <20070624193932.GA11797@clifford.at>
In-Reply-To: <20070624193932.GA11797@clifford.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706242221.57507.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sunday 24 June 2007, Clifford Wolf wrote:
> I'm working on an MPC8349E based project and as some of you might know this
> chip has a four channel (bus-) memory-to-memory DMA controller.
> 
> Unfortunately the linux kernel is atm lacking a generic interface for such
> DMA controllers.

So what's wrong with the include/linux/dmaengine.h API? I thought it was
designed to cover this sort of DMA controller?

	Arnd <><
