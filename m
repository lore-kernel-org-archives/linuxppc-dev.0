Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 984F3679F4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 05:41:59 +1000 (EST)
In-Reply-To: <20060425193109.GE1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<01B6C49A-F82A-47CF-B7B8-106BC0BBDF14@kernel.crashing.org>
	<20060425193109.GE1132@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9B6B0875-F0FD-47B4-8552-1AAF118AAF63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 14:41:54 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 2:31 PM, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 02:20:03PM -0500, Kumar Gala wrote:
>>
>> On Apr 25, 2006, at 1:53 PM, Eugene Surovegin wrote:
>>
>>> On Tue, Apr 25, 2006 at 01:33:38PM -0500, Kumar Gala wrote:
>>>> I personally dont have any time or interesting in it.
>>>
>>> So, don't break compatibility if you don't have time/interest to fix
>>> it. We can wait till someone who "wants to move forward" can do this
>>> professionally without screwing everybody else.
>>
>> If I break compatibility for boards I maintain I don't see the issue
>> as long as I provide a workable solution.
>
> Sorry, but IMO saying you have to upgrade firmware is not a workable
> solution.

I disagree.  I think its completely reasonable to deprecate the  
interface and require people to upgrade over some give time period.

> Firmware <-> kernel is external interface. Kernel shouldn't break it
> unless there is a good technical reason to do so. Developer
> convenience or lack of time is not a good technical reason in my book.

I dont see it as breaking the interface.  I see it as deprecation of  
the current interface.

- kumar
