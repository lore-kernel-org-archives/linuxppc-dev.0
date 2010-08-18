Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7C905B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 15:47:53 +1000 (EST)
Date: Tue, 17 Aug 2010 22:48:12 -0700 (PDT)
Message-Id: <20100817.224812.226786243.davem@davemloft.net>
To: sam@ravnborg.org
Subject: Re: 64-bit ppc rwsem
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100818053955.GA11962@merkur.ravnborg.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<20100818053955.GA11962@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 18 Aug 2010 07:39:55 +0200

>> @@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
>>  lib-$(CONFIG_SPARC32) += copy_user.o locks.o
>>  lib-y                 += atomic_$(BITS).o
>>  lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
>> -lib-y                 += rwsem_$(BITS).o
>> +lib-$(CONFIG_SPARC32) += rwsem_$(BITS).o
> 
> You could write this explicit as:
> 
>> +lib-$(CONFIG_SPARC32) += rwsem_32.o
> 
> As rwsem_64 is gone now.

Sure, I'll make that change, thanks Sam.
