Date: Fri, 8 Dec 2000 13:45:45 +0100 (MET)
Message-Id: <200012081245.NAA11500@na13.mathematik.uni-tuebingen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Ethernet problems on Lombard with kernel 2.2.18pre24
Cc: oliver@e-math.ams.org, jcarr@mail.linuxppc.org
From: Marcel Oliver <oliver@uni-tuebingen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since I installed the LinuxPPC beta release on my Lombard Powerbook,
I experience severe problems with the ethernet port:

- Cannot get transmission rates past about 50-100 k/sec

- Tramsmitions of large files (several MB and up) on the LAN are
  likely to have some corruption

- Things get better when transmitting at (slower) internet speeds

The kernel version is 2.2.18pre24 as included with the beta, and the
problems are with the prebuild kernel as well as with a more
minimalistic self-compiled kernel.

I should add that the ethernet on Lombard was always somewhat flaky,
but things have gotten much much worse with the upgrade.

There are some older and somewhat inconclusive posts on this list
about ethernet problems on Lombard. Is there any new understandingn of
the problem, or can I help to provide more debug information?

--Marcel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
