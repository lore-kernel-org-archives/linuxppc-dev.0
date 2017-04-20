Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7wVh4SD9zDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 20:45:00 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id h41so14926558ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:45:00 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <58F6C088.8020304@gmail.com>
 <20170418224953.685943a3@grimm.local.home>
 <641aa8ee-9b54-716a-77a1-076cafb95e3a@linux.vnet.ibm.com>
 <58F81EF4.5070304@gmail.com>
Cc: robh+dt@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 nfont@linux.vnet.ibm.com, mpe@ellerman.id.au, mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F89110.1020904@gmail.com>
Date: Thu, 20 Apr 2017 03:44:32 -0700
MIME-Version: 1.0
In-Reply-To: <58F81EF4.5070304@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/17 19:37, Frank Rowand wrote:
> On 04/19/17 11:45, Tyrel Datwyler wrote:
>> On 04/18/2017 07:49 PM, Steven Rostedt wrote:
>>> On Tue, 18 Apr 2017 18:42:32 -0700
>>> Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>>> And of course the other issue with using tracepoints is the extra space
>>>> required to hold the tracepoint info.  With the pr_debug() approach, the
>>>> space usage can be easily removed for a production kernel via a config
>>>> option.
>>>
>>> Now if you are saying you want to be able to enable debugging without
>>> the tracing infrastructure I would agree. As the tracing infrastructure
>>> is large. But I'm working on shrinking it more.
>>
>> The primary consumers of OF_DYNAMIC seem to be pseries and powernv where
>> we are generally going to see the trace infrastructure enabled by
>> default in production.
> 
> Another primary consumer will be overlays for ARM expansion boards.  Still
> a work in progress.

And dynamic configuration for the FPGA folks.


> -Frank
> 
>>
>> -Tyrel
>>
>>>
>>>>
>>>> Tracepoints are wonderful technology, but not always the proper tool to
>>>> use for debug info.
>>>
>>> But if you are going to have tracing enabled regardless, adding a few
>>> more tracepoints isn't going to make the difference.
>>>
>>> -- Steve
>>>
>>>>
>>>>> If Rob wants to convert printk() style data to trace data (and I can't
>>>>> convince him otherwise) then I will have further comments on this specific
>>>>> patch.
>>>>>
>>
>> .
>>
> 
> .
> 
