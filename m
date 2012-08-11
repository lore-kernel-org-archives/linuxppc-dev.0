Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40A142C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 17:01:23 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so2147574vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 00:01:20 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20120810222121.GA9408@tyr.buserror.net>
References: <20120810222121.GA9408@tyr.buserror.net>
Date: Sat, 11 Aug 2012 09:01:19 +0200
Message-ID: <CAMuHMdUZmT3g1+6yBPK3LAjTO-orE3Fh7QUP7AB5Kj8o4M4_1g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/epapr: export epapr_hypercall_start
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2012 at 12:21 AM, Scott Wood <scottwood@freescale.com> wrote:
> +EXPORT_SYMBOL(epapr_hypercall_start);

EXPORT_SYMBOL_GPL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
