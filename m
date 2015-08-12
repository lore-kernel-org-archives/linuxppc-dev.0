Return-Path: <ppc@mindchasers.com>
Received: from smtp.webfaction.com (mail6.webfaction.com [74.55.86.74])
 by lists.ozlabs.org (Postfix) with ESMTP id 99EC21A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 13:47:07 +1000 (AEST)
Message-ID: <55CABC70.50106@mindchasers.com>
Date: Tue, 11 Aug 2015 23:24:32 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: Ran Shalit <ranshalit@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 gdb <gdb@sourceware.org>
Subject: Re: gdb with powerpc
References: <CAJ2oMhLr9aoZ258hm0-xuRuW5iksLMOgNOL=hQh6S4SteFNDeg@mail.gmail.com>
In-Reply-To: <CAJ2oMhLr9aoZ258hm0-xuRuW5iksLMOgNOL=hQh6S4SteFNDeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2015 12:50 PM, Ran Shalit wrote:
> Hello,
>
> I would like to ask if anyone tried remote debugging with
> gdb/gdbserver on powerpc.
>
[snip]
>                                 ^
>
> As an alternative, Is anyone familiar with binary package with
> gdb/gdbserver for powerpc used with x86 host ?

I use the powerpc toolchain built using the Yocto Project recipes, and 
this includes gdb and gdbserver (if you include the gdb recipe ).  I can 
run gdb remotely and on my target ( both 32-bit and 64-bit targets ).

They also have pre-built toolchains that might include gdb, but I don't 
use them.


>
> Best Regards,
> Ran
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
