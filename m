Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 8A1A31A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 06:00:25 +1100 (AEDT)
Date: Sun, 15 Feb 2015 11:07:29 -0800 (PST)
Message-Id: <20150215.110729.1985006476906451021.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH net-next 1/6] ppc: Kconfig: Enable BPF JIT on ppc32
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424024154.2685.1.camel@perches.com>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
 <1424023605-2416-2-git-send-email-kda@linux-powerpc.org>
 <1424024154.2685.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, kda@linux-powerpc.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Sun, 15 Feb 2015 10:15:54 -0800

> On Sun, 2015-02-15 at 21:06 +0300, Denis Kirjanov wrote:
> []
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> []
>> @@ -126,7 +126,7 @@ config PPC
>>  	select IRQ_FORCED_THREADING
>>  	select HAVE_RCU_TABLE_FREE if SMP
>>  	select HAVE_SYSCALL_TRACEPOINTS
>> -	select HAVE_BPF_JIT if PPC64
>> +	select HAVE_BPF_JIT
> 
> trivia:
> 
> Should this be the last patch of the series?

Yes, that's the way I see it too.
