Date: Tue, 26 Jun 2001 16:25:03 +0200
From: Michael Peeters <michael@vub.ac.be>
To: linuxppc-dev@lists.linuxppc.org, scmeyers@telocity.com
Subject: Re: Problems with 2.4.5
Message-ID: <20010626162503.F1859@wheeler.vub.ac.be>
Reply-To: Michael.Peeters@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Scott,
I'm having exactly the smae problem.
Apparently __change_bit and some other nonatomic bit operation are not
defined in asm-ppc/bitops.h. I made a patch. I'll mail at your own peril:
this is my first attempt at muddling in kernel stuff (but it is mostly
cut_and_paste, so I think ... it should work - it does for me anyway).

It compiles, but I haven't had the chance to reboot the machine yet
(it is at a remote location).

I you want, I'll keep you posted

Yours,
Michael Peeters

P.S. Could it be I have a book you wrote ? Or is this a question you
are getting sick and tired of getting ?

--
----------------------------------------------------
Michael Peeters (MultiPlex) michael.peeters@ieee.org
  Need Privacy? http://www.keyserver.net/
Tel: 02/629.36.57                Fax: 02/629.34.50
====================================================
Vrije Universiteit Brussel
Faculty of Applied Sciences
Department of Applied Physics and Photonics
VUB-TW-TONA, Pleinlaan 2, B-1050 Brussels, Belgium
----------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
