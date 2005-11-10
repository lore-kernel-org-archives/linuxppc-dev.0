Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E77A686FA
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2005 05:02:26 +1100 (EST)
In-Reply-To: <20051110164404.GA7303@pb15.lixom.net>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
	<20051110164404.GA7303@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <57EFA3C9-E24D-4D98-82EA-AAC634C838C1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 10 Nov 2005 11:12:48 -0600
To: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: add support for new powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 10, 2005, at 10:44 AM, Olof Johansson wrote:

> On Wed, Nov 09, 2005 at 09:38:37PM -0800, Andrew Morton wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>
>>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> I don't think I'm adding much value handling ppc/ppc64 patches,  
>> really.
>> I'd prefer to get out of that business.
>
> Main benefit for me, as a patch submitter, is that you consistently,
> always, ACK when you pick up or drop a patch. In other words, I don't
> have to go polling a tree to see if it made it in or not.
>
>> It would be better to have an arch maintainer who runs a git tree,  
>> same as
>> ia64, arm, etc.
>>
>> And, given the amount of shared infrastructure, I suspect it would  
>> have to
>> be a single git tree for both architectures.
>>
>> I'd still sweep up random ppc patches, but those will go into  
>> mainline via the
>> originator->mm->git-powerpc->linus route.
>>
>> Possible?
>
> I'm fine with all that; to be honest I haven't been certain where the
> smaller ppc/ppc64 patches should go during this whole merge  
> business (or
> after, for that matter).
>
> If Paulus wants to start an arch tree, that's fine with me. I do share
> Ben's opinion about less review though, I guess we'll just have to  
> deal
> with that.
>
> Also, Paul, I kindly request some sort of ACK mechanism similar to
> Andrew's when patches are picked up. :-)

I agree with Olof's comments.  Additionally, I think one reason we  
had been sending things to Andrew for PPC32 embedded was that the sub- 
arch maintainers (Matt, Marcelo, Tom, Dan, Sylvain, myself, etc..)  
needed a responsive path to get things to Linus which Andrew was  
providing.  If Paul's going to be able to handle accepting and  
dealing with all the embedded patches I'm fine with having a PPC git  
tree.  I'm even willing to setup some GIT tree's for sub-arch's I  
deal with for Paul to pull from if he wants.

Just my two cents.

- kumar
