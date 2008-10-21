Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 088F9DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:45:34 +1100 (EST)
Message-Id: <392E3825-8E5D-46B0-84CA-24A701BEDF96@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1224547898.7654.210.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'for-2.6.28' branch
Date: Mon, 20 Oct 2008 22:45:27 -0500
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<1224547898.7654.210.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 20, 2008, at 7:11 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2008-10-20 at 13:04 -0500, Kumar Gala wrote:
>> Please pull from 'for-2.6.28' branch of
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
>> for-2.6.28
>>
>> to receive the following updates:
>
> Ok so I'm not too happy. Kumar, you need to be a little bit more  
> careful
> with your git tree. Here are a few things that are causing me problems
> at the moment and making me not pull this one. Some of them I already
> sent separate emails for but let's put it all together:
>
> - First, please try to keep a consistent merge branch. Even if it ends
> up merging separate branches from you internally.

Yeah, I got the message.

> - Please use git request-pull or at least provide me with the merge
> base in the email if it's not my current master or next HEAD, and  
> since
> it makes my life a bit harder too, please try to have your tree  
> based on
> mine unless you have some conflicts to sort out.

will do.

> - Please spend a bit more time cleaning up the cset subjects and
> comments. For example:
>
> 	"powerpc: remove device_type = "boad_control"
>
> There are a few problems with this one. Not everybody knows what
> "device_type" is, it's not obvious that it's a device-tree change, and
> you may notice that I've been trying to keep the first character after
> the category: uppercase. I would have preferred something like:
>
> 	powerpc: Remove device_type = "board_control" properties in .dts  
> files
>
> Another one that doesn't pass my criteria is:
>
> 	OF: SPI: specify chip select active high
>
> I don't like caps, and it's not the generally accepted format. It  
> should
> be something like:
>
> 	of/spi: Provide a way to specify chip select polarity
>
> Nicer heh ?

If you had conventions on naming this is the first I've heard of  
them.  I know Paul asked about the [POWERPC] to powerpc: change on list.

> I almost always rewrite subjects and sometimes fixup descriptions  
> when I
> merge patches. Please do so too.

I do so as well.  As stated above, if there are naming conventions  
that are desired I'm happy to conform but just need to know what they  
are.

> - Finally, the Kconfig change shouldn't have been in your tree at all,
> or at least not without my or paulus ack and prior argeement that it
> should be merged that way. No big deal with this obviously correct
> patch but where do we put the limit ?


The limit is based on trust.  I submitted all the other cleanup  
patches to remove PPC_MERGE.  I think I can handle such a patch going  
via my tree.

- k
