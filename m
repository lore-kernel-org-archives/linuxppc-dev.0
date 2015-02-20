Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF4191A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 15:40:39 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
 <87d256kry8.fsf@KB00016249.iskra.kb>
 <1424403272.26444.1.camel@ellerman.id.au>
Date: Fri, 20 Feb 2015 11:40:33 +0700
In-Reply-To: <1424403272.26444.1.camel@ellerman.id.au> (Michael Ellerman's
 message of "Fri, 20 Feb 2015 14:34:32 +1100")
Message-ID: <87a909xkji.fsf@KB00016249.iskra.kb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If I just get a patch saying "removed unused foo()", I have to go and dig=
 and
> find out:
>   - was it recently added and will be used soon?
>   - is it ancient and never used, if so can we work out why, ie. feature X
>     never landed so this code is no longer needed.
>   - is it old code that *was* used but isn't now because commit ... remov=
ed the
>     last user.
>   - is it code that *should* be used, but isn't for some odd reason?
>
>
> So if you can provide that sort of detail for me, that really adds value =
to the
> patch. Otherwise the patch is basically just a TODO for me, to go and wor=
k out
> why the code is unused.

Got it. Will resend the whole series one of these days.

Ars=C3=A9ny


> cheers
