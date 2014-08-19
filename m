Return-Path: <bobby.prani@gmail.com>
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com
 [IPv6:2a00:1450:4010:c04::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 770B21A004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:23:47 +1000 (EST)
Received: by mail-lb0-f169.google.com with SMTP id s7so6085688lbd.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 15:23:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408486751.4058.37.camel@snotra.buserror.net>
References: <1408484166-20711-1-git-send-email-bobby.prani@gmail.com>
 <1408486751.4058.37.camel@snotra.buserror.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 19 Aug 2014 18:23:12 -0400
Message-ID: <CAJhHMCAA3rLkszp=Fk9mC81f9+qe8JU_TB6RG3rzdnmpR07jJA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Make 256k pages depend on PPC32=n
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 6:19 PM, Scott Wood <scottwood@freescale.com> wrote:

>>  config PPC_256K_PAGES
>>       bool "256k page size" if 44x
>> -     depends on !STDBINUTILS
>> +     depends on !PPC32 && !STDBINUTILS
>>       help
>>         Make the page size 256k.
>>
>
> How will this ever be selected then?  44x is 32-bit only.

Indeed. I am actually confused about the error which is being thrown
here. The operand (65536) is actually within the range. Any suggestions
on how to fix this?


-- 
Pranith
