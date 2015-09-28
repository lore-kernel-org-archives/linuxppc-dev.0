Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B29381A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 19:56:28 +1000 (AEST)
Received: by ykft14 with SMTP id t14so171682562ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 02:56:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443430694.3171.6.camel@neuling.org>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
 <1443153700-15395-2-git-send-email-mikey@neuling.org>
 <1474940.LhqZEdbX4W@wuerfel>
 <CAOJe8K2SDPFUXBtPcFUcu9=UwCA1rC2rcHzowSA-b=1G+9+6JA@mail.gmail.com>
 <20150925093746.GA21535@visitor2.iram.es>
 <1443430694.3171.6.camel@neuling.org>
Date: Mon, 28 Sep 2015 12:56:26 +0300
Message-ID: <CAOJe8K226iObK=8dMGX+-CYFHzixk-UGeSDYNACGi0Nj37gTXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Gabriel Paubert <paubert@iram.es>, Arnd Bergmann <arnd@arndb.de>,
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

On 9/28/15, Michael Neuling <mikey@neuling.org> wrote:
> On Fri, 2015-09-25 at 11:37 +0200, Gabriel Paubert wrote:
>> On Fri, Sep 25, 2015 at 12:28:30PM +0300, Denis Kirjanov wrote:
>> > On 9/25/15, Arnd Bergmann <arnd@arndb.de> wrote:
>> > > On Friday 25 September 2015 14:01:39 Michael Neuling wrote:
>> > >> This adds a benchmark directory to the powerpc selftests and adds a
>> > >> gettimeofday() benchmark to it.
>> > >>
>> > >> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> > >> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> > >>
>> > >
>> > > Any reason for keeping this powerpc specific? It seems generally
>> > > useful.
>> > > and portable.
>> > You're right. Moreover, we can put some comment to the benchmark why
>> > we've made such decision to add it (reference to the commit
>> > "powerpc/vdso: Avoid link stack corruption in __get_datapage()")
>>
>> Why gettimeofday? Isn't clock_gettime the modern variant?
>
> We can do either here really.  I just wanted to test __get_datapage()
> really.  I just stole the benchmark from Anton, which turned into mpe
> wanting it in selftests.  I dumped it in powerpc mostly because I knew
> mpe would take it (ie. I'm was being lazy).

Yeah, so the quickest way would be to apply the patch as is. Then
someone can make it generic.
So now it depends on Michael's decision :)
>
>> BTW: dows anyone receive 2 copies of every messge in this thread ?
>
> I'm not.
>
> Mikey
>
>>
>> I do, and I suspect that this is due to the Cc: list having both
>> linuxppc-dev@ozlabs.org and linuxppc-dev@lists.ozlabs.org. I removed the
>> former for this reply.
>>
>>     Gabriel
>
>
