Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69CD11A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:36:01 +1100 (AEDT)
Received: by yhai57 with SMTP id i57so1558208yha.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 13:35:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424381177.22771.1.camel@ellerman.id.au>
References: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
 <20150219.155613.1219259214030608341.davem@davemloft.net>
 <CAOJe8K0awkwdYNZr5GdRJFQLCJ0F1GOF730Q3UwT7KBJw0c7Uw@mail.gmail.com>
 <1424381177.22771.1.camel@ellerman.id.au>
Date: Fri, 20 Feb 2015 01:35:59 +0400
Message-ID: <CAOJe8K1qWYOXRvHqV44JsEkOhXXKsCCN8fQ=wmy=3VHLSMpm0Q@mail.gmail.com>
Subject: Re: bpf: Enable BPF JIT on ppc32
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/20/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2015-02-20 at 01:07 +0400, Denis Kirjanov wrote:
>> On 2/19/15, David Miller <davem@davemloft.net> wrote:
>> > From: Denis Kirjanov <kda@linux-powerpc.org>
>> > Date: Tue, 17 Feb 2015 10:04:37 +0300
>> >
>> >> This patch series enables BPF JIT on ppc32. There are relatevily
>> >> few chnages in the code to make it work.
>> >>
>> >> All test_bpf tests passed both on 7447a and P2041-based machines.
>> >>
>> >> Changelog:
>> >> v1 - > v2: Reordered Kconfig patch in the series
>> >
>> > Who plans to take this series?  A PowerPC maintainer?
>> >
>> > If not, should I take it?
>>
>> I think that it should go through your tree...
>
> I'm happy for Dave to take it.
>
> But did you test 64-bit as well?

Sure!

> cheers
>
>
>
