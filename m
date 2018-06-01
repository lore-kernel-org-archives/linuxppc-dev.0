Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y10z62zCzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:34:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 0/4] powerpc patches for new Kconfig language
In-Reply-To: <CAK7LNASxgQOsSveFuKrx7do-+643KUZwU_Gn+z7O7JK+TtMEww@mail.gmail.com>
References: <20180530121922.22122-1-npiggin@gmail.com>
 <87o9gxyzpo.fsf@concordia.ellerman.id.au>
 <CAK7LNARoj4g5Wf2Do1npiQUeTpiiFZLuNdmW4JfZw2D-Oe++jw@mail.gmail.com>
 <87k1rkzbry.fsf@concordia.ellerman.id.au>
 <CAK7LNARbz8YC7=vB_Pt-FFepLfLY-Yt=8ZiOAoPeZV3EA3VQOg@mail.gmail.com>
 <876034yrek.fsf@concordia.ellerman.id.au>
 <CAK7LNASxgQOsSveFuKrx7do-+643KUZwU_Gn+z7O7JK+TtMEww@mail.gmail.com>
Date: Fri, 01 Jun 2018 20:34:42 +1000
Message-ID: <871sdq4wxp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
...
>
> Also, the change logs could be dropped.
>
> I see
>
> Since v1: reworded changelog to explain the cause of the problem (thanks
> Segher) and moved the flags into the 64-32 cross compile case.
>
> or
>
> Since v1: removed extra -EB in the recordmcount script (thanks mpe)
>
>
> above your signed-off-by.
>
>
> Of course, this is your call,
> and you do not need to disturb the git history if it is too late.

You're right, sorry those are bit messy.

I'm happy to update them, I haven't merged them yet, but I see you have
them in your tree.

So I won't change them unless you confirm you're OK with it. Let me
know.

cheers
