Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 669D0DDD0A
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 00:10:59 +1000 (EST)
Message-ID: <46B5DAE9.9060406@ru.mvista.com>
Date: Sun, 05 Aug 2007 18:12:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [patch 06/10] 40x decrementer fixes
References: <20070803160900.069522000@linux.vnet.ibm.com> >	
	<20070803161710.931656000@linux.vnet.ibm.com> >	
	<46B35C07.4090806@ru.mvista.com> <46B3617B.10509@ru.mvista.com>
	<1186194537.5733.4.camel@gruick>
In-Reply-To: <1186194537.5733.4.camel@gruick>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>>    Why bother doing this?! This will only warrant you imprecise decrementer 
>>>interrupts while it should be interrupting at the precise period currently (if 
>>>you load PIT once)...
>>
>>    I.e. the error will only accumulate. NAK.

> No, it won't since the timebase is always used as the reference.

    I meant the error in the interrupt period itself (I know that this gets 
accounted for) but that was a thinko anyway...

> Ben.

WBR, Sergei
