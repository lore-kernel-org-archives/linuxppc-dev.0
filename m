Date: Mon, 29 Jan 2001 19:12:36 +0000
Subject: Re: network stack oops 2.4.1/gcc 2.95.3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010129191225.AB75C2EFD2@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  Has there been any follow up to this problem report?  Is this a
> regression from gcc-2.95.2 behavior?  Franz's pre-releases do not exactly
> correspond to the GCC development pre-releases, so I have no idea when
> this problem began or whether it is local to the linuxppc branch.

It is not a regression test.  It would not be particularly easy, either to
put 2.95.2 back up and wind back the system to the build conditions...

but the version used was 2.95.3-test2. and the bk pull was 2.4.1-pre10.

The only reason I associated gcc at all (and copied this to Franz) was that
I don't recall ever seeing an Illegal Instruction oops before.

Unfortunately, (or fortunately depending on your POV) it is not reproducible
to order.  It seems to depend on network load - maybe one time in 20 with a
heavily loaded network?

The system is booted OK

It is in the transition from single to init 5 (where portmap & named are
launched in my set-up).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
