From: Sorin Balea <sorin@nitechinc.com>
Reply-To: sorin@nitechinc.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: compiling 2.3.18 with fpu emulation
Date: Wed, 17 Nov 1999 15:57:29 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99111716012800.26272@splash.nitechinc.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all

I'm trying to compile 2.3.18 with fpu emulation and i get some errors like

math.c: In function `record_exception':
math.c:162: structure has no member named `tss'
math.c:208: structure has no member named `tss'
math.c: In function `do_mathemu':
math.c:362: structure has no member named `tss'
math.c:363: structure has no member named `tss'
......
math.c:451: structure has no member named `tss'
math.c:462: structure has no member named `tss'    

Anyone has a fix for this?

BTW, i've switched from FADS to a MBX board, there is a BIG difference....
in the last 24 hours i've been able to do more with the MBX than in a couple
of weeks with the FADS

Best regards

Sorin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
