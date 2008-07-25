Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 791FDDE0D0
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 01:07:57 +1000 (EST)
Message-Id: <BAF7B55C-75C2-4BCA-8686-34A843865C91@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1216973590.11188.99.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [git pull] Please pull from powerpc.git merge branch
Date: Fri, 25 Jul 2008 10:07:43 -0500
References: <1216973590.11188.99.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 25, 2008, at 3:13 AM, Benjamin Herrenschmidt wrote:

>
> Benjamin Herrenschmidt (1):
>      Move update_mmu_cache() declaration from tlbflush.h to pgtable.h

I'm guessing this was pretty trivial, but please post patches to the  
list even if you've committed them to your tree.

- k
