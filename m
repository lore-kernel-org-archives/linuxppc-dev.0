Date: Tue, 7 Sep 1999 11:08:48 +1000
Message-Id: <199909070108.LAA01543@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: otto@cable.a2000.nl
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <37D3F17F.F876DEC1@cable.a2000.nl> (message from Otto Moerbeek on
	Mon, 06 Sep 1999 18:53:18 +0200)
Subject: Re: 2.2.12 and USB on a B&W G3
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37D36242.9A70B7F2@cable.a2000.nl> <199909060712.RAA00937@tango.anu.edu.au> <37D3F17F.F876DEC1@cable.a2000.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Otto Moerbeek <otto@cable.a2000.nl> wrote:

> I would like to get these USB patches, so I can try to run my USB
> devices on 2.2.12. Are they available somewhere?

The easiest thing, from my point of view at least, is for you to get
my current 2.2 tree by anonymous rsync from
samba.anu.edu.au::linux-pmac-stable.  I could make a patch if you need
it.

> Apart from the USB stuff, should the rest of 2.2.12 work on a B&W G3?
> IOW have the other patches reached the 2.2.12 tree or should I expect
> some more problems?

2.2.12 is relatively up-to-date w.r.t. the PPC port.  I have heard
though that vger-current doesn't work on B&W G3s, so possibly vanilla
2.2.12 won't either.  I heard recently that my linux-pmac-stable tree
does, though.

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
