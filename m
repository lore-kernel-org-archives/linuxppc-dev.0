Return-Path: <vwool@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 014DB67D82
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 09:18:39 +1100 (EST)
Subject: Re: [PATCH] adding ROM chips to device tree: respin
From: Vitaly Wool <vwool@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <45510013.8010509@ru.mvista.com>
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>
	<4550A5E6.50409@ru.mvista.com> <1162934221.2680.2.camel@barja>
	<4550F9B8.40901@ru.mvista.com> <1162935862.2680.7.camel@barja>
	<45510013.8010509@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 01:18:40 +0300
Message-Id: <1162937920.2680.10.camel@barja>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>     We don't have any actual registers (at least "physmap" doesn't know about 
> them anyway) I think, just a memory range. What registers are you talking about?

We do have registers there, in query mode. The CFI registers.

> > Okay, probably we can go you way naming of_device by what it's
> > compatible with. So that "physmap" compatible would be called
> > "physmap-flash", "nand"-compatible would be called "nand-flash" etc.
> 
>     Actually, Generic Names spec tells to use the most generic user-parsable 
> names, just like I used initally ("flash")...
> 
> > Does that work for you?
> 
>     No. Getting rid of "physmap" completely and using of_find_node_by_type() 
> does. :-)

That's effectively what I'm talking about. Find the device by type and
register it with the name which depends on what it's compatible with.

Vitaly
