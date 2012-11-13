Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 1EED62C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 09:17:41 +1100 (EST)
Date: Tue, 13 Nov 2012 17:17:36 -0500 (EST)
Message-Id: <20121113.171736.561094209116852795.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH V2] wanrouter: Remove it and the drivers that depend on it
From: David Miller <davem@davemloft.net>
In-Reply-To: <1352837845.12850.3.camel@joe-AO722>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
 <20121113.144406.1610017702502358739.davem@davemloft.net>
 <1352837845.12850.3.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jcmvbkbc@gmail.com,
 harryxiyou@gmail.com, paulus@samba.org, linux@arm.linux.org.uk, richard@nod.at,
 linux-xtensa@linux-xtensa.org, rob@landley.net,
 user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
 xiyoulinuxkernelgroup@googlegroups.com,
 user-mode-linux-user@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, isdn@linux-pingi.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 linux-kernel@zh-kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Tue, 13 Nov 2012 12:17:25 -0800

> That seems an odd workflow as it leaves dangling CONFIG_<foo>
> options set, but I guess it doesn't hurt so here it is.

As you said it's harmless, and more importantly it avoids
unnecessary conflicts.

> I just removed the modified arch/.../<foo>defconfig files.

Something is not right here:

[davem@drr net-next]$ git am --signoff V2-wanrouter-Remove-it-and-the-drivers-that-depend-on-it.patch 
Applying: wanrouter: Remove it and the drivers that depend on it
error: removal patch leaves file contents
error: net/wanrouter/Kconfig: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/Makefile: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/patchlevel: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/wanmain.c: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/wanproc.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_drv.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_main.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_x25.c: patch does not apply
error: removal patch leaves file contents
error: include/linux/cyclomx.h: patch does not apply
error: removal patch leaves file contents
error: include/linux/cycx_drv.h: patch does not apply
error: removal patch leaves file contents
error: include/linux/wanrouter.h: patch does not apply
error: removal patch leaves file contents
error: include/uapi/linux/wanrouter.h: patch does not apply
