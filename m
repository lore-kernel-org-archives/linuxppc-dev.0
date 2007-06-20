Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 142D9DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 02:03:13 +1000 (EST)
Message-ID: <46795026.8040502@ru.mvista.com>
Date: Wed, 20 Jun 2007 20:04:54 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix I8042 IRQs on MPC8641 HPCN
References: <1182298509.5674.356.camel@rhino>
	<567a30ea184b6efc37e4c5df60fea1ac@kernel.crashing.org>
In-Reply-To: <567a30ea184b6efc37e4c5df60fea1ac@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> 	 * IRQ 9:  Level
>> 	 * IRQ 10: Level
>> 	 * IRQ 11: Level
>>-	 * IRQ 12: Level
>>+	 * IRQ 12: Edge
>> 	 * IRQ 14: Edge
>> 	 * IRQ 15: Edge
>> 	 */
>>-	outb(0xfa, 0x4d0);
>>-	outb(0x1e, 0x4d1);
>>+	outb(0xf8, 0x4d0);
>>+	outb(0x0e, 0x4d1);
> 
> 
> The comment doesn't mention IRQ13.  You're changing IRQ9
> to edge as well; is this an accident?

    Whare -- I'm only seeing bit 1 changing which corresponds to IRQ1 and is 
reserved (0) anyway.

>  If not, you need
> to change the comment too.

WBR, Sergei
