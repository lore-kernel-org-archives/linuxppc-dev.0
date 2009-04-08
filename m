Return-Path: <amodra@bigpond.net.au>
Received: from nskntmtas05p.mx.bigpond.com (nskntmtas05p.mx.bigpond.com
	[61.9.168.149]) by ozlabs.org (Postfix) with ESMTP id 28B22DE3F7
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 15:12:04 +1000 (EST)
Date: Wed, 8 Apr 2009 14:42:03 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure
Message-ID: <20090408051202.GA27796@bubble.grove.modra.org>
References: <20090408140407.14dc5242.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090408140407.14dc5242.sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 02:04:07PM +1000, Stephen Rothwell wrote:
>   LD      vmlinux.o
> powerpc-linux-ld: TOC section size exceeds 64k

I'm starting to sound like a cracked record, but I'll say it again:
ld -r does not merely package together object files, it transforms
them.   Try using thin archives instead.

-- 
Alan Modra
Australia Development Lab, IBM
