Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1883ADDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 03:03:53 +1000 (EST)
Message-Id: <4BD688FB-13AF-4076-BF9A-1F7BEA7E7D65@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1215621093.32502.1.camel@weaponx>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Updates to powerpc.git
Date: Wed, 9 Jul 2008 11:47:45 -0500
References: <1215588881.8970.358.camel@pasglop>
	<7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
	<20080710020832.3e654bc9.sfr@canb.auug.org.au>
	<20080709162008.GC28130@secretlab.ca>
	<1215621093.32502.1.camel@weaponx>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 11:31 AM, Josh Boyer wrote:

> On Wed, 2008-07-09 at 10:20 -0600, Grant Likely wrote:
>> On Thu, Jul 10, 2008 at 02:08:32AM +1000, Stephen Rothwell wrote:
>>> Kumar,
>>>
>>> On Wed, 9 Jul 2008 07:58:38 -0500 Kumar Gala <galak@kernel.crashing.org 
>>> > wrote:
>>>>
>>>> What is your intent with the 'master' branch?  I hope you do NOT  
>>>> plan
>>>> on ever rebasing it.  I assume if a patch gets into master and we  
>>>> drop
>>>> it you'll do a git-revert of it?
>>>
>>> "Ever" is such a strong word.  Even Paul on occasion rebased his  
>>> master
>>> branch.  I see no reason why Ben could not run his master (or maybe
>>> better named "test") branch as a place that patches come and go  
>>> and his
>>> "next" branch as something that never (or very rarely) gets  
>>> rebased with
>>> commits progressing from master (test) to next when he is  
>>> satisfied with
>>> them. People should then base further work in the "next" branch.
>>
>> I was under the impression that there was some consensus that -next
>> branches should be used for unstable experiments.  Am I mistaken?
>
> Yes,  you are.  It's slightly confusing.  -next branches are for  
> things
> decidedly going into the "next" release of the kernel.  If they are
> unstable, they aren't really proven to be ready then.

Did, GregKH start up a tree for code not quite ready ( -staging).

I think master and -next should not be rebased (if it can be  
avoided).  and -staging can be.

- k
