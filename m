Message-ID: <9A9C83C019F35D47A570460E87D5D8AB0125EAB9@racerx.ixiacom.com>
From: Dan Kegel <dkegel@ixiacom.com>
To: "'Conn Clark '" <clark@esteem.com>,
	"'May Ling List '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: What problems are there with floating point emulation in the
	kernel?
Date: Wed, 22 May 2002 12:27:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Since it's very easy to avoid the use of floating point in
the kernel, it has not been a big issue.

Do you need to use floating point in the kernel for some reason?
- Dan

-----Original Message-----
From: Conn Clark
To: May Ling List
Sent: 4/24/2002 9:56 AM
Subject: What problems are there with floating point emulation in the
kernel?


Hello everyone,

	I've been told on this list that there are problems fpu
emulation
in the kernel. I was curoius as to what the errors are and the aftermath
(pun intended) that occurs when they are encountered. ( Like are the
values off a little bit or a lot, does it cause a kerel panic, does it
block interupts, does it unleash a terible monster that will destroy the
universe, etc... .)

	I'm also very supprised that Motorola and IBM haven't dedicated
some resources to address these problems since their fpu-less chips are
often used in linux designs.

thanks in advance,

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
