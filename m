Message-Id: <200101291918.OAA28870@mal-ach.watson.ibm.com>
To: "Iain Sandoe" <iain@sandoe.co.uk>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: network stack oops 2.4.1/gcc 2.95.3 
In-Reply-To: Message from "Iain Sandoe" <iain@sandoe.co.uk>
   of "Mon, 29 Jan 2001 19:12:36 GMT." <20010129191225.AB75C2EFD2@apollo.valhalla.net>
Date: Mon, 29 Jan 2001 14:18:24 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Iain Sandoe" writes:

Iain> It is not a regression test.  It would not be particularly easy, either to
Iain> put 2.95.2 back up and wind back the system to the build conditions...

Iain> but the version used was 2.95.3-test2. and the bk pull was 2.4.1-pre10.

	A regression is different from a regression test.  I never called
it a regression test.

	I do not mean rewinding all of the way to gcc-2.95.2, but to
Franz's patched version of GCC prior to the gcc-2.95.3 changes.

	I am just trying to narrow down whether this is something new.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
