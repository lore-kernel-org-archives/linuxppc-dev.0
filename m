Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 4CF0D679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 20:41:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sys_vmsplice
Date: Fri, 21 Apr 2006 12:41:35 +0200
References: <20060421080239.GC4717@suse.de> <20060421092158.GE4717@suse.de>
	<20060421022555.2d460805.akpm@osdl.org>
In-Reply-To: <20060421022555.2d460805.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604211241.36596.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 April 2006 11:25, Andrew Morton wrote:
> It might be better to just stick the new entry into the spufs table, make
> sure that the powerpc guys see it go in.  That way, ppc64 people (Linus,
> maybe you?) can test it.
> 
> I guess mapping it onto sys_ni_syscall would be safest.
> 
> (It's been broken since sys_tee went in, btw).

The BUILD_BUG_ON in there was just overkill. How about if we just add a
small comment to the systbl on powerpc to remind people about the fact
that there is another file to edit? Patch follows.

	Arnd <><
