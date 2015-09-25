Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f177.google.com (mail-yk0-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 962E71A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 19:28:33 +1000 (AEST)
Received: by ykdz138 with SMTP id z138so109636006ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 02:28:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1474940.LhqZEdbX4W@wuerfel>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
 <1474940.LhqZEdbX4W@wuerfel>
Date: Fri, 25 Sep 2015 12:28:30 +0300
Message-ID: <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 mpe@ellerman.id.au,
 benh@kernel.crashing.org, Aaron Sawdey <sawdey@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org, anton@samba.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/25/15, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
>> This adds a benchmark directory to the powerpc selftests and adds a
>> gettimeofday() benchmark to it.
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>
>
> Any reason for keeping this powerpc specific? It seems generally useful.
> and portable.
You're right. Moreover, we can put some comment to the benchmark why
we've made such decision to add it (reference to the commit
"powerpc/vdso: Avoid link stack corruption in __get_datapage()")

>
> 	Arnd
>
