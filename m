Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zcars04f.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48908DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 01:34:23 +1000 (EST)
Message-ID: <46D43C11.2070105@nortel.com>
Date: Tue, 28 Aug 2007 09:15:29 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: what is ~1MB of memory allocated at fffea000-fffff000 on ppc64?
References: <46D3326C.3000505@nortel.com>	<20070827203157.GD13612@kryten>
	<46D34A9E.7010501@nortel.com>
	<18131.45155.16087.714489@cargo.ozlabs.ibm.com>
In-Reply-To: <18131.45155.16087.714489@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Chris Friesen writes:

>>For some background, we're running an emulator that uses a null pointer 
>>value of 0xffff0000 and we want any accesses to that address to trap.

> Can you fix this in userspace instead by moving the stack down below
> 0xffff0000 and then doing munmap(0xffff0000, 0x1000) ?

It sounds like it would work.  I'm not entirely clear on how to move the 
starting point of the stack though--could you elaborate or point me to a 
reference?

Chris
