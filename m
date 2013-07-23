Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE51B2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 12:41:19 +1000 (EST)
Message-ID: <1374547276.8308.12.camel@joe-AO722>
Subject: Re: [PATCH] hashtable: add hash_for_each_possible_rcu_notrace()
From: Joe Perches <joe@perches.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 22 Jul 2013 19:41:16 -0700
In-Reply-To: <51EDEA39.3000400@ozlabs.ru>
References: <1373084210-27767-1-git-send-email-aik@ozlabs.ru>
 <51E3C92B.2070704@ozlabs.ru> <51EDEA39.3000400@ozlabs.ru>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-23 at 12:28 +1000, Alexey Kardashevskiy wrote:
> Anyone, ping. Is it good, bad, ugly (ack/nack)? Thanks!
> 
> Is there any "trivial patches" list? Could not find it on vger.

Jiri Kosina has trivial@kernel.org

Also, there's kernel-janitors

http://vger.kernel.org/vger-lists.html#kernel-janitors
http://kernelnewbies.org/KernelJanitors

MAINTAINERS has an entry:

TRIVIAL PATCHES
M:	Jiri Kosina <trivial@kernel.org>
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
S:	Maintained
K:	^Subject:.*(?i)trivial
