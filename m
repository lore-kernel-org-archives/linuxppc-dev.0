Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65E8DDDF79
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 02:05:41 +1000 (EST)
In-Reply-To: <1183130011.30145.35.camel@weaponx.rchland.ibm.com>
References: <1182952173.9889.4.camel@weaponx.rchland.ibm.com>
	<1183128867.1170.341.camel@pmac.infradead.org>
	<1183130011.30145.35.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00b4db6df4432cc8c611a0e4673db87c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Schedule removal of arch/ppc
Date: Fri, 29 Jun 2007 18:05:25 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +      remain in bug-fix only mode until it's scheduled removal.  
>>> Platforms
>>
>> http://www.angryflower.com/itsits.gif
>
> That's it?  I'm scheduling the demise of an entire architecture 
> sub-tree
> and the only comment you can make is about a superfluous apostrophe? ;)

Oh there are bigger issues with your patch...

s/the the/to the/

> Anyway, I'll fix it after waiting a bit more to see if anyone has
> further comments.

I think we all agree arch/ppc/ has to DIE so it's all up
to Paul now to schedule its execution...


Segher
