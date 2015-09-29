Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2E491A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:19:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 04:19:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 43E8C3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:19:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TIJIrg62128264
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:19:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TIIqhe011824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:18:53 +1000
Message-ID: <560AD654.1060401@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2015 23:50:04 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 nikunj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 anton@samba.org, grant.likely@linaro.org, cl@linux.com,
 khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gkurz@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 0/5] powerpc:numa Add serial nid support
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
 <20150928170455.GA48470@linux.vnet.ibm.com>
In-Reply-To: <20150928170455.GA48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 10:34 PM, Nishanth Aravamudan wrote:
> On 28.09.2015 [13:44:42 +0300], Denis Kirjanov wrote:
>> On 9/27/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
>>> Problem description:
>>> Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
>>> numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
>>> got from device tree is naturally mapped (directly) to nid.
>>
>> Interesting thing to play with, I'll try to test it on my POWER7 box,
>> but it doesn't have the OPAL layer :(

Hi Denis,
Thanks for your interest. I have pushed the patches to

https://github.com/ktraghavendra/linux/tree/serialnuma_v1 if it makes
  patches easy to grab.

>
> Note that it's also interesting to try it under PowerVM, with odd NUMA
> topologies and report any issues found :)
>

Thanks Nish, I 'll also grab a powerVM and test.
