Return-Path: <wolfgang.reissnegger@xilinx.com>
Date: Thu, 24 May 2007 21:26:14 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com> <465561A4.9020403@dlasys.net>
	<46558E54.80909@ru.mvista.com>
	<20070524154211.169C7AE8051@mail10-fra.bigfish.com>
	<465640C1.1060206@dlasys.net>
In-Reply-To: <465640C1.1060206@dlasys.net>
Content-Type: text/plain; charset=us-ascii
Message-Id: <20070525042616.35988808054@mail150-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> Wolfgang Reissnegger wrote:
>> Hi Andrei, David,
>>
>> It's great to hear that Andrei's git tree is active again.
>>
>> As you might have heard, Xilinx is in the process of setting up a git
>> tree as well. Right now we are waiting for the new hosting machines to
>> be installed. We should get those machines up and running shortly
>> (within a couple weeks).
>>   
> Absolutely fantastic - however I think kernel.org would be happy to host
> your git tree for you
> as well as a few other places. Those are locations people would look for
> public git trees.
> I beleive you can still excecise some control. I beleive they are free -
> though I suspect kernel.org would not
> mind contributions from xilinx.

I agree, and I already requested kernel.org site hosting a while back,
but I did not get a response yet.

[snip]

> For me the most significant issue is the bazillion layers of nested
> macro's and includes.

I don't see the macros as an issue, just look at the implementation of,
for example, spin_lock_irq() and Xilinx's macros seem like child's play :-)
As for includes, yes, there are a few too many header files. But, as
time progresses and the need arises they can be merged into fewer files.

> The kernel style guides atleast to me are primarily about the
> readability and understandability of the code.
> not where the curly brackets are.
> 
>> I'll send an update once we have the server up and running.
>>
>> Thanks,
>>    Wolfgang
