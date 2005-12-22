Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 25FAC688D6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 01:21:12 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jBMEU7iD023004
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Dec 2005 16:30:07 +0200 (EET)
Message-ID: <43AAB508.7000007@intracom.gr>
Date: Thu, 22 Dec 2005 16:15:36 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <43A98F90.9010001@varma-el.com> <43AA65F4.10409@intracom.gr>
	<43AAAEA2.8030200@varma-el.com>
In-Reply-To: <43AAAEA2.8030200@varma-el.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, jes@trained-monkey.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrey Volkov wrote:
> Hi Pantelis,
> 
> Pantelis Antoniou wrote:
> 
>>Andrey Volkov wrote:
>>

[snip]

>>
>>Hi Andrey,
>>
>>FYI, on arch/ppc/lib/rheap.c theres an implementation of a remote heap.
>>
>>It is currently used for the management of freescale's CPM1 & CPM2 internal
>>dual port RAM.
>>
>>Take a look, it might be what you have in mind.
>>
>>Regards
>>
>>Pantelis
> 
> 
> Thanks I missed it (and small wonder! :( ).
> 
> Andrew, Is somebody count HOW MANY dev specific implementation
> of buddy/first-fit allocators now in kernel?
> 

Yes, it is indeed messy.

The rheap implementation is generic enough and I believe can fit most of the
special memory allocators needs. If you'd like I could move it somewhere
generic and test it.

Regards

Pantelis
