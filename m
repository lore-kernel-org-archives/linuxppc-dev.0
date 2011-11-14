Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7ADC9B7213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 07:50:14 +1100 (EST)
Received: by iafi7 with SMTP id i7so8242133iaf.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 12:50:10 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
References: <cover.1320917551.git.joe@perches.com>
 <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
Date: Mon, 14 Nov 2011 21:50:10 +0100
Message-ID: <CAMuHMdXwjFphNNHc-OZXHaC4OP981x48hRuCdi3FjtPKh6YvHA@mail.gmail.com>
Subject: Re: [PATCH 3/5] treewide: Remove useless NORET_TYPE macro and uses
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-s390@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-m68k@lists.linux-m68k.org,
 Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Ingo Molnar <mingo@elte.hu>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 10:41, Joe Perches <joe@perches.com> wrote:
> It's a very old and now unused prototype marking
> so just delete it.
>
> Neaten panic pointer argument style to keep checkpatch quiet.
>
> Signed-off-by: Joe Perches <joe@perches.com>

For the m68k parts:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
