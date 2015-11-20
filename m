Return-Path: <kirjanov@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4981A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 23:17:54 +1100 (AEDT)
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3279314030F
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2015 23:17:54 +1100 (AEDT)
Received: by wmec201 with SMTP id c201so18710223wme.1
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2015 04:17:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448020825.14769.3.camel@ellerman.id.au>
References: <1447964589-4244-1-git-send-email-kda@linux-powerpc.org>
 <1448020825.14769.3.camel@ellerman.id.au>
Date: Fri, 20 Nov 2015 15:17:50 +0300
Message-ID: <CAHj3AV=FTgQNNtcWtyS6X6D0UcnUCrRPaJxv5QU1a1=COJbuMQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: wire up sys_mlock2
From: Denis Kirjanov <kirjanov@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Thu, 2015-11-19 at 23:23 +0300, Denis Kirjanov wrote:
>
>> Tested with tools/testing/selftests/vm/mlock2-tests
>> both on ppc64 and ppc32
>
> Actually I did this myself and it's been in my fixes branch (which is in
> linux-next) for a few days. I just asked Linus to pull it.

Ok, great!
>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--=20
Regards / Mit besten Gr=C3=BC=C3=9Fen,
Denis
