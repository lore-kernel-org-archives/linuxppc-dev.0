Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 736512C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 17:52:45 +1000 (EST)
Message-ID: <1374565947.3916.74.camel@pasglop>
Subject: Re: [PATCH] hashtable: add hash_for_each_possible_rcu_notrace()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joe Perches <joe@perches.com>
Date: Tue, 23 Jul 2013 17:52:27 +1000
In-Reply-To: <1374548005.8308.15.camel@joe-AO722>
References: <1373084210-27767-1-git-send-email-aik@ozlabs.ru>
 <51E3C92B.2070704@ozlabs.ru> <51EDEA39.3000400@ozlabs.ru>
 <1374547276.8308.12.camel@joe-AO722> <51EDEDC6.2040007@ozlabs.ru>
 <1374548005.8308.15.camel@joe-AO722>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Sasha Levin <sasha.levin@oracle.com>,
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

On Mon, 2013-07-22 at 19:53 -0700, Joe Perches wrote:
> Anyway, you cc'd all the right people already.
> 
> If no one responds after a couple weeks, either
> send it to Jiri or directly to Linus.

Or I'll just merge it with the rest of the series.

Cheers,
Ben.
