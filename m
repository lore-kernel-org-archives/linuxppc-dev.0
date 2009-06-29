Return-Path: <kernelmailz@googlemail.com>
Received: from mail-fx0-f205.google.com (mail-fx0-f205.google.com
	[209.85.220.205])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C0FF7B70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 02:01:10 +1000 (EST)
Received: by fxm1 with SMTP id 1so1213457fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 09:01:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e997b7420906290836u72bd6abbw553df5e77f097349@mail.gmail.com>
References: <e997b7420906290647g7717e55bp210f0f57d8c531c0@mail.gmail.com>
	<BD32B91E-83B3-4ED5-A5C1-60B8B6EF9B3C@kernel.crashing.org>
	<e997b7420906290836u72bd6abbw553df5e77f097349@mail.gmail.com>
Date: Mon, 29 Jun 2009 21:31:07 +0530
Message-ID: <abe8a1fd0906290901y46316d63h7b6849d103475d51@mail.gmail.com>
Subject: Re: How to implement kexec on e500 ?
From: kernel mailz <kernelmailz@googlemail.com>
To: "wilbur.chan" <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did some searching on the archieve

Looks like this is a old patch
[PATCH 03/10] powerpc: Add kexec support for PPC_85xx platforms
Dale Farnsworth
Thu, 22 Nov 2007 07:51:52 -0800

Is this the patch you were referring to kumar

-TZ


On Mon, Jun 29, 2009 at 9:06 PM, wilbur.chan<wilbur512@gmail.com> wrote:
> Excuse me ,
>
> btw,how to search these patches on this maillist?
>
> through Linuxppc-dev Archives one by one?
>
> Cheers,
>
> wilbur
>
> 2009/6/29, Kumar Gala <galak@kernel.crashing.org>:
>>
>> On Jun 29, 2009, at 8:47 AM, wilbur.chan wrote:
>>
>>> kernel 2.6.21.7
>>>
>>> As we know , kexec stores =A0data =A0for new kernel image , =A0in the f=
orm
>>> of =A0 a page list.
>>>
>>> And kexec uses the physical address of the another =A0page for a
>>> "next-page" pointer.
>>>
>>> However, PowerPC e500 =A0does not allow users to turn off the MMU, so w=
e
>>> can not used physical address directly in our code.
>>>
>>>
>>> Someone suggested that changing =A0relocate_kernel.S to add a TLB 1-to-=
1
>>> mapping of DRAM .
>>>
>>> What does "mapping" mean ?
>>>
>>> Any suggestion to implement kexec on e500 ?
>>
>> Wilbur, kexec has been implemented on e500. =A0There are some patches on
>> the list for this and they just need to be respun and reviewed again.
>>
>> - k
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
