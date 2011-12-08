Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6A9621007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 22:54:52 +1100 (EST)
Received: by wgbdt12 with SMTP id dt12so1074668wgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2011 03:54:46 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop>
 <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Date: Thu, 8 Dec 2011 12:54:46 +0100
Message-ID: <CAMuHMdWM=dQDHmH=WmngB9dRFF-v+NgP2CPdAX5hVQX=iayA+A@mail.gmail.com>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Thu, Dec 8, 2011 at 12:26, Finn Thain <fthain@telegraphics.com.au> wrote=
:
> On Thu, 8 Dec 2011, Benjamin Herrenschmidt wrote:
>> On Thu, 2011-12-08 at 15:20 +1100, Benjamin Herrenschmidt wrote:
>> > So basic operations seem to work, I've applied the patch to
>> > powerpc-next.
>
> Then I guess Geert should not push this for 3.3 -- or does it make no
> difference?

I do not plan to push it myself, that's why it's not in my for-next branch.
The for-3.3 is just indicative.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
