Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCCED1A01E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 17:45:48 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, Aaron Sawdey <sawdey@us.ibm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, Steve Munroe <sjmunroe@us.ibm.com>,
 linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
Date: Fri, 25 Sep 2015 09:39:56 +0200
Message-ID: <1474940.LhqZEdbX4W@wuerfel>
In-Reply-To: <1443153700-15395-2-git-send-email-mikey@neuling.org>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
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

On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
> This adds a benchmark directory to the powerpc selftests and adds a
> gettimeofday() benchmark to it.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 

Any reason for keeping this powerpc specific? It seems generally useful.
and portable.

	Arnd
