Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Cross compilation question
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <1063093493.12979.4.camel@toni>
Mime-Version: 1.0
Date: Tue, 09 Sep 2003 09:44:54 +0200
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've installed ELDK as compiler-set, and it is successfully used to
compile linuxppc_2_4_devel, rtai and FLTK for my EP405 board.

Now I have a FLTK-based program which I like to cross-compile, but I get
stuck to one error I cannot solve right now:

ppc_4xx-g++ -static -g test.cxx -I/ppc/fltk-1.1.4rc2 -o test
-L/opt/eldk/ppc_4xx/lib -L/opt/eldk/ppc_4xx/usr/lib
-L/ppc/fltk-1.1.4rc2/lib -L/opt/PPC_X/usr/X11R6/lib -L/opt/PPC_X/usr/lib
-lfltk -lXext -lX11
/opt/eldk/usr/ppc-linux/bin/ld: cannot find -lstdc++
collect2: ld returned 1 exit status

As far as I know, is libstdc++.so in /opt/eldk/ppc_4xx/usr/lib, which is
added as -L.

Anyone who know the solution (which will probably be easy).

Regards.
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
