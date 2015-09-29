Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F23A01A2D40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:46:08 +1000 (AEST)
Received: by ykdg206 with SMTP id g206so17996148ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 12:46:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <560AD654.1060401@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
 <20150928170455.GA48470@linux.vnet.ibm.com>
 <560AD654.1060401@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 22:46:05 +0300
Message-ID: <CAOJe8K1TBhJbqRck=Ayd7wgjUdRWXdHoXoHMRin=Uv5V5bpD2g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] powerpc:numa Add serial nid support
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au, nikunj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 anton@samba.org, grant.likely@linaro.org, cl@linux.com,
 khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gkurz@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/29/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
> On 09/28/2015 10:34 PM, Nishanth Aravamudan wrote:
>> On 28.09.2015 [13:44:42 +0300], Denis Kirjanov wrote:
>>> On 9/27/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
>>>> Problem description:
>>>> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
>>>> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
>>>> got from device tree is naturally mapped (directly) to nid.
>>>
>>> Interesting thing to play with, I'll try to test it on my POWER7 box,
>>> but it doesn't have the OPAL layer :(
>
> Hi Denis,
> Thanks for your interest. I have pushed the patches to
>
> https://github.com/ktraghavendra/linux/tree/serialnuma_v1 if it makes
>   patches easy to grab.

Thanks!
One sad thing is that I can't test the actual node id mapping now
since currently I have an access to machine with only one memory node
:/ Can we fake it through qemu?

>
>>
>> Note that it's also interesting to try it under PowerVM, with odd NUMA
>> topologies and report any issues found :)
>>
>
> Thanks Nish, I 'll also grab a powerVM and test.
>
>
>
>
>
