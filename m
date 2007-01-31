Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5177DDF06
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 15:42:57 +1100 (EST)
In-Reply-To: <20070131073947.67520c16@localhost.localdomain>
References: <20070130230711.21111.52924.stgit@localhost.localdomain>
	<20070130230859.21111.39370.stgit@localhost.localdomain>
	<F739E1EE-3BA6-428D-8C96-AB09E1B9773B@kernel.crashing.org>
	<20070131073947.67520c16@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20C6E81C-CB34-461A-B1CD-FF302D83E2AB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads
Date: Tue, 30 Jan 2007 22:41:57 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 10:39 PM, Vitaly Bordug wrote:

> On Tue, 30 Jan 2007 17:41:14 -0600
> Kumar Gala wrote:
>
>>
>> On Jan 30, 2007, at 5:09 PM, Vitaly Bordug wrote:
>>
>>>
>>> Recent update of asm-powerpc/io.h caused cpm-related stuff to
>>> break in the
>>> current kernel. Current patch fixes it, as well as other
>>> inconsistencies
>>> expressed, that do not permit targets from working properly:
>>>
>>> - Updated dts with a chosen node with interrupt controller,
>>
>> Why do we need this?  I'm not aware of any other boards having to
>> set this?
>
> Correct. In fact I dropped that change, after "dtc -f"  discussion  
> but forgot
> to clear this line from desc. Will resend in a few minutes, thanks  
> for pointing it out.

I think the 8272 dts still had the node in it.

- k
