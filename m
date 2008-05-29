Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0E022DE172
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 17:10:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 09:10:06 +0200
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<1211926779.3286.104.camel@pasglop>
In-Reply-To: <1211926779.3286.104.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200805290910.07207.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 May 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-27 at 14:55 -0700, Linus Torvalds wrote:
> > 
> > On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > > 
> > > A problem with __raw_ though is that they -also- don't do byteswap,
> > 
> > Well, that's why there is __readl() and __raw_readl(), no?
> 
> As I replied to somebody else, __readl() is news to me :-) we dont' have
> those on powerpc.
> 

It's not exactly a well-established interface. Only five architectures
define these functions, and there is not a single user in the kernel
source outside of these architecture's io.h files.

	Arnd <><
