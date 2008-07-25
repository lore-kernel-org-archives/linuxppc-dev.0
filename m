Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF9FBDE070
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:14:27 +1000 (EST)
Date: Fri, 25 Jul 2008 11:10:56 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull from powerpc.git merge branch
In-Reply-To: <1216973590.11188.99.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0807251108320.5249@nehalem.linux-foundation.org>
References: <1216973590.11188.99.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 25 Jul 2008, Benjamin Herrenschmidt wrote:
> 
> ﻿git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Ok, I got a conflict in arch/powerpc/platforms/52xx/Kconfig, you should 
check that I fixed it up right and send me follow-up patches if required.

		Linus
