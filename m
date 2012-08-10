Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3B9B2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 17:43:57 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so1211640vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 00:43:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
Date: Fri, 10 Aug 2012 09:43:54 +0200
Message-ID: <CAMuHMdV9dgjdHuz3avU1dubyekcZwT70x=5W+CL7iHQuoC1n_w@mail.gmail.com>
Subject: [-next] ERROR: "epapr_hypercall_start" [drivers/tty/ehv_bytechan.ko]
 undefined!
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linuxppc-dev@lists.ozlabs.org, Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sicne a few days, powerpc allmodconfig fails with:

ERROR: "epapr_hypercall_start" [drivers/tty/ehv_bytechan.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2

http://kisskb.ellerman.id.au/kisskb/buildresult/6883300/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
