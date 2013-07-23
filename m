Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 03E882C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 12:43:28 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so7816058pbc.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 19:43:26 -0700 (PDT)
Message-ID: <51EDEDC6.2040007@ozlabs.ru>
Date: Tue, 23 Jul 2013 12:43:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] hashtable: add hash_for_each_possible_rcu_notrace()
References: <1373084210-27767-1-git-send-email-aik@ozlabs.ru>
 <51E3C92B.2070704@ozlabs.ru> <51EDEA39.3000400@ozlabs.ru>
 <1374547276.8308.12.camel@joe-AO722>
In-Reply-To: <1374547276.8308.12.camel@joe-AO722>
Content-Type: text/plain; charset=KOI8-R
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

On 07/23/2013 12:41 PM, Joe Perches wrote:
> On Tue, 2013-07-23 at 12:28 +1000, Alexey Kardashevskiy wrote:
>> Anyone, ping. Is it good, bad, ugly (ack/nack)? Thanks!
>>
>> Is there any "trivial patches" list? Could not find it on vger.
> 
> Jiri Kosina has trivial@kernel.org
> 
> Also, there's kernel-janitors
> 
> http://vger.kernel.org/vger-lists.html#kernel-janitors
> http://kernelnewbies.org/KernelJanitors
> 
> MAINTAINERS has an entry:
> 
> TRIVIAL PATCHES
> M:	Jiri Kosina <trivial@kernel.org>
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
> S:	Maintained
> K:	^Subject:.*(?i)trivial


Cool, thanks! But is that patch really trivial? :)


-- 
Alexey
