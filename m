Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id DAE0767FC4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 13:42:18 +1000 (EST)
In-Reply-To: <1124317852.24373.13.camel@localhost.localdomain>
References: <1124317852.24373.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8DC63AB4-C547-4023-BE7F-46176BC71535@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 22:42:12 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2005, at 5:30 PM, David Woodhouse wrote:

> On Thu, 2005-08-18 at 07:44 +1000, Benjamin Herrenschmidt wrote:
>
>> On Wed, 2005-08-17 at 09:00 -0500, Kumar Gala wrote:
>>
>>> David's 8250 cleanup patch made me wondering when are machine checks
>>>
>
>
>>> suppose to recoverable?  General class of conditions is what I'm
>>> looking for here.
>>>
>>> Is David's case due to some PCI master abort or something else?
>>>
>>
>> Might be some issue on SMP machines...
>>
>
> Yeah, that'll probably be the reason it turns out _not_ to be
> recoverable despite our expectations. But that wasn't Kumar's  
> question.

David's right, that wasn't my question :)  I was asking more about  
what cases do we actually recover and that is considered correct  
behavior.

- kumar
