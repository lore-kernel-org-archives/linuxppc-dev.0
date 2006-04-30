Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1812679EF
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 23:04:21 +1000 (EST)
In-Reply-To: <200604301342.02043.arnd@arndb.de>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
	<20060430042059.GO5518@pb15.lixom.net>
	<200604301342.02043.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A15F2F5A-81AC-4192-B171-CF966C955272@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: please pull powerpc.git 'merge' branch
Date: Sun, 30 Apr 2006 15:04:08 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> We already have SMT, ICACHE_SNOOP and ALTIVEC feature bits, so it  
>> probably
>> makes sense to stay in the ARCH_2_05 direction. Unfortunately it  
>> might
>> be tricky to rename the old defines now due to userland exposure.
>>
>> I guess Cell breaks all this logic though. Which PPC base version  
>> does
>> it implement?
>
> The Cell Broadband Engine Architecture in theory is 2.03 and also  
> mandates

The docs (for example, "CBE_Architecture_v10.pdf") say 2.02.  One  
more reason
to not use those arch version numbers.


Segher
