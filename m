To: Tony Mantler <nicoya@apia.dhs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Success? Both CPUs running (Was: Bogus interrupt -1)
References: <20010420171327.26883@mailhost.mipsys.com>
	<85itjzilbx.fsf@junk.nocrew.org>
	<20010420171327.26883@mailhost.mipsys.com>
	<v04003a02b709cb418690@[24.70.162.12]>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Date: 12 May 2001 20:18:13 +0200
In-Reply-To: <v04003a02b709cb418690@[24.70.162.12]>
Message-ID: <85y9s2sa6y.fsf_-_@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler <nicoya@apia.dhs.org> writes:
> At 4:52 AM -0500 4/23/2001, Lars Brinkhoff wrote:
> > However, it still seems like one CPU hangs after some time.
>
> A friend of mine is having trouble with one CPU hanging in his dual G4
> under MacOS X. You may want to check to make sure you don't have a hardware
> problem.
>
> The symptoms are pretty much (from what he's told me): The system runs for
> a while, then one of the CPUs goes off into la-la land never to return
> again. Not very complicated.

It seems to me there was a bug in benh 2.4.4-pre1.  I'm now running bk
2.4.5-pre1, and I have never seen a CPU hang.

--
http://lars.nocrew.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
