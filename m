Message-ID: <38EBE21E.FEA62A2C@rochcivictheatre.org>
Date: Wed, 05 Apr 2000 20:02:22 -0500
From: Tom Gall <gall@rochcivictheatre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Printing to the OF command line
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  This is an act of desperation on my part. But what the heck.

  I'm trying to bring up a the 2.2.15pre14 kernel on an unsupported box.
It's a 7043 43P 140 RS 6000. It's a labor of love.

  Anyway, I've been having trouble even getting the kernel up any
distance to even be able to puts to the screen. Something is dieing ...
somewhere.

  in arch/ppc/boot/of1275.c it would seem one should be able to perhaps
open up some of device and print directly to the of command line without
having to get into display adaptor issues. I would hope this would allow
debugging in very difficult environments. (Which I'm in)

  Has anyone ever done this with this particular API? Is it even
possible?

  Thanks!


--
Hakuna Matata,

Tom

-----------------------------------------------------------
Linux Guy          "My heart is human, my blood is boiling,
tgall@uswest.net    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
