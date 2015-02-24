Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E137C1A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:48:15 +1100 (AEDT)
Message-ID: <1424753295.2318.5.camel@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Tue, 24 Feb 2015 15:48:15 +1100
In-Reply-To: <87a909xkji.fsf@KB00016249.iskra.kb>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
 <87d256kry8.fsf@KB00016249.iskra.kb>
 <1424403272.26444.1.camel@ellerman.id.au>
 <87a909xkji.fsf@KB00016249.iskra.kb>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2015-02-20 at 11:40 +0700, Arseny Solokha wrote:
> > If I just get a patch saying "removed unused foo()", I have to go and dig and
> > find out:
> >   - was it recently added and will be used soon?
> >   - is it ancient and never used, if so can we work out why, ie. feature X
> >     never landed so this code is no longer needed.
> >   - is it old code that *was* used but isn't now because commit ... removed the
> >     last user.
> >   - is it code that *should* be used, but isn't for some odd reason?
> >
> >
> > So if you can provide that sort of detail for me, that really adds value to the
> > patch. Otherwise the patch is basically just a TODO for me, to go and work out
> > why the code is unused.
> 
> Got it. Will resend the whole series one of these days.

Thanks.

cheers
