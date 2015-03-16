Return-Path: <peter@hurleysoftware.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ED451A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 01:01:19 +1100 (AEDT)
Received: by qcyi15 with SMTP id i15so44125062qcy.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 07:01:15 -0700 (PDT)
Message-ID: <5506E228.3050204@hurleysoftware.com>
Date: Mon, 16 Mar 2015 10:01:12 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Pranith Kumar <bobby.prani@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux panic on 4.0.0-rc4
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
 <1426493810.4716.0.camel@ellerman.id.au>
 <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
In-Reply-To: <CAJhHMCC06H-BRFBBcD_PfumyvHoFAjbi_MOn7gSeq5y093FSEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/16/2015 09:30 AM, Pranith Kumar wrote:
> On Mon, Mar 16, 2015 at 4:16 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> On Mon, 2015-03-16 at 01:34 -0400, Pranith Kumar wrote:
>>> On Mon, Mar 16, 2015 at 1:11 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> I have a power mac mini 32-bit system.
>>>>
>>> ...
>>>> You can see the panic message here: http://imgur.com/s1lH15g. (there
>>>> is no log and I have no serial console).
>>>
>>> There was some debug code in there when it hit. The actual hang seems
>>> to be in printk_late_init(). It does not return from this. May be this
>>> is a hint?
>>
>> That is where the boot consoles get disabled and it switches to the "real"
>> console. It suggests that the system is not "hung" there but you just lost
>> output.
>>
>> Try booting with "keep_bootcon" ?
> 
> I tried this and got to the same place as in the first mail:
> http://imgur.com/s1lH15g
> 
> There is a kernel panic with the message printed. Any more suggestions
> to how to debug this?

git bisect.

Regards,
Peter Hurley
 
