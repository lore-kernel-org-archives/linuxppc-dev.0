Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B81281A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 16:14:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 11:44:47 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 94844E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:44:30 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U6EieT3080656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:44:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U6Ehp6015810
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:44:44 +0530
Message-ID: <560B7E30.20702@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 11:46:16 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>
CC: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, nikunj@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, anton@samba.org, grant.likely@linaro.org,
 cl@linux.com, khandual@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, gkurz@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 0/5] powerpc:numa Add serial nid support
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
 <20150928170455.GA48470@linux.vnet.ibm.com>
 <560AD654.1060401@linux.vnet.ibm.com>
 <CAOJe8K1TBhJbqRck=Ayd7wgjUdRWXdHoXoHMRin=Uv5V5bpD2g@mail.gmail.com>
In-Reply-To: <CAOJe8K1TBhJbqRck=Ayd7wgjUdRWXdHoXoHMRin=Uv5V5bpD2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2015 01:16 AM, Denis Kirjanov wrote:
> On 9/29/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
>> On 09/28/2015 10:34 PM, Nishanth Aravamudan wrote:
>>> On 28.09.2015 [13:44:42 +0300], Denis Kirjanov wrote:
>>>> On 9/27/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
>>>>> Problem description:
>>>>> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
>>>>> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
>>>>> got from device tree is naturally mapped (directly) to nid.
>>>>
>>>> Interesting thing to play with, I'll try to test it on my POWER7 box,
>>>> but it doesn't have the OPAL layer :(
>>
>> Hi Denis,
>> Thanks for your interest. I have pushed the patches to
>>
>> https://github.com/ktraghavendra/linux/tree/serialnuma_v1 if it makes
>>    patches easy to grab.
>
> Thanks!
> One sad thing is that I can't test the actual node id mapping now
> since currently I have an access to machine with only one memory node
> :/ Can we fake it through qemu?
>

faking the sparse numa ids is possible with Nish's patch for qemu:

https://lists.gnu.org/archive/html/qemu-devel/2014-06/msg05826.html
