Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPc6x4nsdzDw6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 22:14:47 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-11-20
Date: Thu, 24 Nov 2016 12:14:30 +0100
Message-ID: <4210730.SKFQpWgOdg@wuerfel>
In-Reply-To: <fde89288-e3bc-356f-8d64-6f9a1cf23c47@leemhuis.info>
References: <fde89288-e3bc-356f-8d64-6f9a1cf23c47@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday, November 20, 2016 4:09:51 PM CET Thorsten Leemhuis wrote:
> 
> == Fixed since last report ==
> 
> Desc: module loadling broken due to kbuild changes
> Repo: 16-10-15 http://www.gossamer-threads.com/lists/linux/kernel/2544734
> Stat: Fixes https://git.kernel.org/torvalds/c/4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187 https://git.kernel.org/torvalds/c/4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187
> Note: 

This is currently only fixed for powerpc. Fixes for x86 and ARM were
proposed but not merged, and all other architectures don't even have
a fix as far as I can tell.

It's only broken with CONFIG_MODVERSIONS=y though, and not all modules
are affected on all architectures, so a lot of testers have not noticed.

	Arnd
