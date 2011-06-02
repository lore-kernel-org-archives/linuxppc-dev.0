Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id 0D1EEB6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 13:06:50 +1000 (EST)
Date: Wed, 1 Jun 2011 20:06:46 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <1306983467.29297.51.camel@pasglop>
Message-ID: <alpine.DEB.2.01.1106012003370.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
	<1306983467.29297.51.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: zajec5@gmail.com, linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jun 2011 at 12:57, Benjamin Herrenschmidt wrote:
> Ok, thanks a lot, It looks rather trivial actually: That new workaround
> is PCIe specific but is called unconditionally, and will do bad things
> non-PCIe implementations.

Indeed. This PowerBook G4 does not has PCIe, yet the whole SSB thingy gets 
enabled in my .config somehow. Thanks for the quick fix, I tried to revert 
ccc7c28af2... from Linus' current tree, but I had to rip out some more to 
make it compile.

I'll try your fix in a minute and get back to you with those cdrom init 
problems as well.

Thanks,
Christian.
-- 
BOFH excuse #166:

/pub/lunch
