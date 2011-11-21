Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
 by ozlabs.org (Postfix) with ESMTP id 149F9B7213
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 13:03:35 +1100 (EST)
Date: Sun, 20 Nov 2011 18:03:32 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.2.0-rc1 panic on PowerPC
In-Reply-To: <1321840301.13860.9.camel@pasglop>
Message-ID: <alpine.DEB.2.01.1111201759500.8000@trent.utfs.org>
References: <alpine.DEB.2.01.1111150035560.8000@trent.utfs.org>
 <alpine.DEB.2.01.1111201529070.8000@trent.utfs.org>
 <1321837101.13860.6.camel@pasglop>
 <alpine.DEB.2.01.1111201701000.8000@trent.utfs.org>
 <1321838742.13860.8.camel@pasglop>
 <1321840301.13860.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 Nov 2011 at 12:51, Benjamin Herrenschmidt wrote:
> BTW. SLUB or SLAB ? Mine was SLUB with SLUB_DEBUG enabled (tho the debug
> didn't seem to catch anything).

SLUB, and SLUB_DEBUG=y (but w/o SLUB_DEBUG_ON and SLUB_STATS). Full config 
here: http://nerdbynature.de/bits/3.2.0-rc1/oops/config.txt

I'm compiling today's git checkout (mainline) with more debug settings 
enabled[0], let's see if this helps anything.

Christian.

[0] diff to old config
+CONFIG_RT_MUTEX_TESTER=y
+CONFIG_DEBUG_LOCKDEP=y
+CONFIG_DEBUG_HIGHMEM=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_WRITECOUNT=y
+CONFIG_DEBUG_LIST=y
+CONFIG_ATOMIC64_SELFTEST=y
+CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
+CONFIG_XMON_DISASSEMBLY=y
+CONFIG_DEBUGGER=y

-- 
BOFH excuse #242:

Software uses US measurements, but the OS is in metric...
