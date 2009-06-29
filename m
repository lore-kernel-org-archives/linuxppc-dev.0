Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195])
	by bilbo.ozlabs.org (Postfix) with ESMTP id DC8B0B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:36:38 +1000 (EST)
Received: by yxe33 with SMTP id 33so7023218yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 08:36:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BD32B91E-83B3-4ED5-A5C1-60B8B6EF9B3C@kernel.crashing.org>
References: <e997b7420906290647g7717e55bp210f0f57d8c531c0@mail.gmail.com>
	<BD32B91E-83B3-4ED5-A5C1-60B8B6EF9B3C@kernel.crashing.org>
Date: Mon, 29 Jun 2009 23:36:36 +0800
Message-ID: <e997b7420906290836u72bd6abbw553df5e77f097349@mail.gmail.com>
Subject: Re: How to implement kexec on e500 ?
From: "wilbur.chan" <wilbur512@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
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

Excuse me ,

btw,how to search these patches on this maillist?

through Linuxppc-dev Archives one by one?

Cheers,

wilbur

2009/6/29, Kumar Gala <galak@kernel.crashing.org>:
>
> On Jun 29, 2009, at 8:47 AM, wilbur.chan wrote:
>
>> kernel 2.6.21.7
>>
>> As we know , kexec stores  data  for new kernel image ,  in the form
>> of   a page list.
>>
>> And kexec uses the physical address of the another  page for a
>> "next-page" pointer.
>>
>> However, PowerPC e500  does not allow users to turn off the MMU, so we
>> can not used physical address directly in our code.
>>
>>
>> Someone suggested that changing  relocate_kernel.S to add a TLB 1-to-1
>> mapping of DRAM .
>>
>> What does "mapping" mean ?
>>
>> Any suggestion to implement kexec on e500 ?
>
> Wilbur, kexec has been implemented on e500.  There are some patches on
> the list for this and they just need to be respun and reviewed again.
>
> - k
>
