Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x236.google.com (mail-qk0-x236.google.com
 [IPv6:2607:f8b0:400d:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk5346rq1zDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 10:53:04 +1000 (AEST)
Received: by mail-qk0-x236.google.com with SMTP id u68so526279qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 17:53:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467678247.30027.29.camel@neuling.org>
References: <3rjc771dmCz9sCg@ozlabs.org>
 <1467678247.30027.29.camel@neuling.org>
From: oliver <oohall@gmail.com>
Date: Tue, 5 Jul 2016 10:53:01 +1000
Message-ID: <CAOSf1CHE6nbKaC3oxQU48MnNLAhRH=VFD3rikWC2g3K266dp6Q@mail.gmail.com>
Subject: Re: powerpc/mm: Add a parameter to disable 1TB segs
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2016 at 10:24 AM, Michael Neuling <mikey@neuling.org> wrote:
> On Mon, 2016-07-04 at 16:09 +1000, Michael Ellerman wrote:
>> On Mon, 2016-04-07 at 00:44:04 UTC, Oliver O'Halloran wrote:
>> >
>> > This patch adds the kernel command line parameter "no_tb_segs" which
>> > forces the kernel to use 256MB rather than 1TB segments. Forcing the
>> > use
>> > of 256MB segments makes it considerably easier to test code that
>> > depends
>> > on an SLB miss occurring.
>> That's a fairly awful name :)
>>
>> Can you call it "disable_1T_segments" ?
>>
>>
>> It should also be mentioned in Documentation/kernel-parameters.txt, with
>> emphasis that it's a debug option and powerpc only.
>
> To that end, should we add "powerpc_" at the start of the option?

I don't think it's necessary. There are annotations in
kernel-parameters.txt that indicate what options are arch specific and
it looks like none of the existing architecture specific options are
prefixed.

>
> Mikey
