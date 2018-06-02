Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yTNq6ngzzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 14:53:30 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id b17-v6so1889007pfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 21:53:30 -0700 (PDT)
Date: Sat, 2 Jun 2018 14:53:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing
 list <linux-kbuild@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 0/4] powerpc patches for new Kconfig language
Message-ID: <20180602145317.0a6b2efd@roar.ozlabs.ibm.com>
In-Reply-To: <87po1a3alo.fsf@concordia.ellerman.id.au>
References: <20180530121922.22122-1-npiggin@gmail.com>
 <87o9gxyzpo.fsf@concordia.ellerman.id.au>
 <CAK7LNARoj4g5Wf2Do1npiQUeTpiiFZLuNdmW4JfZw2D-Oe++jw@mail.gmail.com>
 <87k1rkzbry.fsf@concordia.ellerman.id.au>
 <CAK7LNARbz8YC7=vB_Pt-FFepLfLY-Yt=8ZiOAoPeZV3EA3VQOg@mail.gmail.com>
 <876034yrek.fsf@concordia.ellerman.id.au>
 <CAK7LNASxgQOsSveFuKrx7do-+643KUZwU_Gn+z7O7JK+TtMEww@mail.gmail.com>
 <871sdq4wxp.fsf@concordia.ellerman.id.au>
 <CAK7LNASwEv8RGi=PtKyDjcwt9DFy93ug22xQAWOJ2b5j+yNkqg@mail.gmail.com>
 <87po1a3alo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 01 Jun 2018 23:22:27 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > 2018-06-01 19:34 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:  
> ...
> >
> > Could you update your branch, please?  
> 
> Done.
> 
> I've only pushed the first three patches this time, to avoid any
> confusion. Hopefully :)
> 
> The top commit is:
> 
>   1421dc6d4829 ("powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS")
> 
> 
> For the fourth one you're welcome to add my ack when you apply it:
> 
>   Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> > Then, I will re-pull the new one.  
> 
> Thanks! Sorry this took a while to get right, next time we'll be much
> better at it ;)

Thank you both for sorting out my mess.

Thanks,
Nick
