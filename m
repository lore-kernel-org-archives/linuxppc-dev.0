Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 19FC2B7219
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 07:50:38 +1100 (EST)
Received: by mail-iy0-f179.google.com with SMTP id i7so8242133iaf.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 12:50:38 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
References: <cover.1320917551.git.joe@perches.com>
 <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Date: Mon, 14 Nov 2011 21:50:37 +0100
Message-ID: <CAMuHMdW+KORv6K6jMxTVOM=EeVQ6JTHHe9cOVfKZ39x4NcgvfQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to
 __noreturn
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-s390@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, linux-m68k@lists.linux-m68k.org,
 Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
 Chris Metcalf <cmetcalf@tilera.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, linux-am33-list@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 10:41, Joe Perches <joe@perches.com> wrote:
> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.
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
