Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408tKy2VXBzF21D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 23:11:49 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 26 Mar 2018 08:11:47 -0400
From: okaya@codeaurora.org
To: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver
 <oohall@gmail.com>, linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 linux-rdma@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: RFC on writel and writel_relaxed
In-Reply-To: <20180326114449.GC6579@arm.com>
References: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
 <CAOSf1CFmoK2XSn0=qAtiVEO9t4i-DHGgfieiedDfuO6E3tpkQw@mail.gmail.com>
 <4e5c745a-8b9b-959e-8893-d99cd6032484@codeaurora.org>
 <1521692689.16434.293.camel@kernel.crashing.org>
 <CAOSf1CFv1HHCL3YOVhRn2U=grdNjaQ=A4m3xwxN2Rek1-_TySg@mail.gmail.com>
 <1521726722.16434.312.camel@kernel.crashing.org>
 <5ccdb208-4664-0a7f-df5d-2e12cbe4c239@codeaurora.org>
 <1521764168.16434.324.camel@kernel.crashing.org>
 <20180326114449.GC6579@arm.com>
Message-ID: <495123579cbc031ca7f1a6b0b305db18@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-03-26 07:44, Will Deacon wrote:
> Hi Ben,
> 
> I don't seem to have the beginning of this thread, so please bounce it 
> over
> if you'd like me to look at it!
> 

https://www.spinics.net/lists/linux-rdma/msg62570.html

https://www.spinics.net/lists/linux-rdma/index.html#62666


> On Fri, Mar 23, 2018 at 11:16:08AM +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2018-03-22 at 12:51 -0500, Sinan Kaya wrote:
>> > On 3/22/2018 8:52 AM, Benjamin Herrenschmidt wrote:
>> > > > > No, it's not sufficient.
>> > >
>> > > Just to clarify ... barrier() is just a compiler barrier, it means the
>> > > compiler will generate things in the order they are written. This isn't
>> > > sufficient on archs with an OO memory model, where an actual memory
>> > > barrier instruction needs to be emited.
>> >
>> > Surprisingly, ARM64 GCC compiler generates a write barrier as
>> > opposed to preventing code reordering.
> 
> In context, this looks like a misunderstanding somewhere. barrier() is 
> a
> compiler barrier for us just like everybody else and we use the generic
> implementation with the empty asm + memory clobber.
> 

True, I clarified it this weekend

https://www.spinics.net/lists/linux-rdma/msg62788.html
