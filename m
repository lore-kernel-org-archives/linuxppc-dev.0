Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8BFE1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 22:47:44 +1000 (AEST)
Received: by ykdz138 with SMTP id z138so113433367ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:47:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150925093746.GA21535@visitor2.iram.es>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
 <1474940.LhqZEdbX4W@wuerfel>
 <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
 <20150925093746.GA21535@visitor2.iram.es>
Date: Fri, 25 Sep 2015 15:47:42 +0300
Message-ID: <CAOJe8K2Osp9Oo0arcPVAgEsfYeTGVVOGT6mt-SUksXk6qoZTFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Neuling <mikey@neuling.org>,
 Steve Munroe <sjmunroe@us.ibm.com>,
 anton@samba.org, Aaron Sawdey <sawdey@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/25/15, Gabriel Paubert <paubert@iram.es> wrote:
> On Fri, Sep 25, 2015 at 12:28:30PM +0300, Denis Kirjanov wrote:
>> On 9/25/15, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
>> >> This adds a benchmark directory to the powerpc selftests and adds a
>> >> gettimeofday() benchmark to it.
>> >>
>> >> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> >> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> >>
>> >
>> > Any reason for keeping this powerpc specific? It seems generally
>> > useful.
>> > and portable.
>> You're right. Moreover, we can put some comment to the benchmark why
>> we've made such decision to add it (reference to the commit
>> "powerpc/vdso: Avoid link stack corruption in __get_datapage()")
>
> Why gettimeofday? Isn't clock_gettime the modern variant?

Mostly, I think, for historical reasons. Both of them are implemented
as vsyscalls (on ppc, ) so why bother?

BTW: Found an interesting vdso testsuite on github:
https://github.com/nlynch-mentor/vdsotest under GPL. Not sure if we
really need such similar thing in the kernel selftest sources.

>
> BTW: dows anyone receive 2 copies of every messge in this thread ?
>
> I do, and I suspect that this is due to the Cc: list having both
> linuxppc-dev@ozlabs.org and linuxppc-dev@lists.ozlabs.org. I removed the
> former for this reply.
>
>     Gabriel
>
