Mime-Version: 1.0
Message-Id: <v04220800b57463822a92@[192.168.0.1]>
Date: Mon, 19 Jun 2000 20:01:27 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: can't build -devel; matroxfb parse error?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just (7pm EDT -0400) rsynced to the linux-pmac-devel tree to try
the latest compile on my PM6500. With all default config options, I
get this error:

matroxfb_base.c:1146: parse error before `matroxfb_set_cmap'
make[4]: *** [matroxfb_base.o] Error 1

I'm using /gcc version 2.95.2 19991024 (release/franzo)/ if that
makes any difference. I don't know how to handle a "parse error."
What is it and how might I fix it (or do I just not compile with
matrox support for now)?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
