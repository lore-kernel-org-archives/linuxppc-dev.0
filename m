Message-Id: <5.1.0.14.2.20020613192014.026b1ad0@pop.prodigy.net>
Date: Thu, 13 Jun 2002 19:21:37 -0700
To: Dan Malek <dan@embeddededge.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D0951C8.6030400@embeddededge.com>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
 <20020613205824.GX13541@opus.bloom.county>
 <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

At 07:15 PM 6/13/2002, Dan Malek wrote:
>Eugene Surovegin wrote:
>
>>This is gfp for _memory_ itself and may contain GFP_DMA for example. I
>>didn't want to allocate
>>struct vm_area from DMA pool in that case.
>
>Well, you are using it for DMA, aren't you? :-)

Yeah, I use _memory_ for DMA, but I don't want waste DMA pool for struct
vm_struct itself.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
