Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06BC31A0015
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 18:53:39 +1000 (AEST)
Received: by obew15 with SMTP id w15so98658509obe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 01:53:36 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
Date: Mon, 1 Jun 2015 10:53:36 +0200
Message-ID: <CAMuHMdXYO4CHD4NHFB44EXozxHPt8zqsLz88SQ_8v_AWEKa-Jg@mail.gmail.com>
Subject: incompatible type for argument 1 of 'htab_convert_pte_flags'
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

http://kisskb.ellerman.id.au/kisskb/buildresult/12433431/

arch/powerpc/mm/hash_utils_64.c:1478:2: error: incompatible type for
argument 1 of 'htab_convert_pte_flags'

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
