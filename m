Date: Wed, 23 Dec 1998 05:21:19 +0100
To: David Ray <daver@idiom.com>
CC: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Test kernels for chipsfb (2400/3400)
Message-Id: <19981223052119.031496@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've uploaded two test kernels at:

<http://calvaweb.calvacom.fr/bh40/vmlinux_test.gz>
<http://calvaweb.calvacom.fr/bh40/vmlinux_test2.gz>

With a couple of additional fixes to chipsfb.c that I would like you to
test, especially in 16 bits mode. (Both console and X, and both XPmac and
XFBDev).

I expect the first one to work but I didn't test since I don't have a
machine with a CT65550 here. I am interested in knowing if the second one
works, it may, it may not.

Basically, the first one declares itself as a truecolor visual (no gamma)
to match the fact that we switch the gamma off on the chip, and the
second one declares itself as a directcolor, enables gamma, and adds one
or two things that may cause the gamma to work, but I'm not sure.

I'll post the patches later (they need cleanup) but in the meantime, I
would like some quick tests by PowerBook 2400/3400 owners.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
