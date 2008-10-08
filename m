Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C0CCDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 16:55:21 +1100 (EST)
Message-Id: <1351959C-EAEB-4C14-8A55-665F4C4C0601@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1223405857.8157.55.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: powerpc.git status
Date: Wed, 8 Oct 2008 00:55:14 -0500
References: <1223357268.8157.38.camel@pasglop>
	<9B078573-0862-4176-A945-E273D78B260F@kernel.crashing.org>
	<1223405857.8157.55.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2008, at 1:57 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2008-10-07 at 07:29 -0500, Kumar Gala wrote:
>> On Oct 7, 2008, at 12:27 AM, Benjamin Herrenschmidt wrote:
>>
>>> While paul was away, I've been taking care of the tree, so currently
>>> up to date is my git at:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>>>
>>> I've pushed a batch of stuff to the "master" branch. I haven't yet
>>> updated the "next" branch, I'm going to let master settle a day or  
>>> two
>>> first just in case.
>>>
>>> I'll update patchwork status asap.
>>
>> Ben, remind me the difference between your 'master' and 'next'
>> branches?  Will you rebase 'master'?
>
> Well, mostly they are the same, let's say that I'm trying to avoid
> rebasing both, but if shit happens, it's better if master gets rebased
> and not next though it's a bit arbitrary and Im not sure it's really
> useful in practice.

Its useful to not rebase a branch you expect people to send you  
patches against and sub-maintainers are using to build tree's  
against.  It sounds like 'next' is that branch.

- k
