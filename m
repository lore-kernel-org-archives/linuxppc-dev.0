Date: Tue, 17 Oct 2000 01:50:54 +0300
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: linuxppc-dev@lists.linuxppc.org
Subject: IrDA on PowerBooks
Message-ID: <20001017015054.A16003@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello. I'm addressing you of this problem of mine because someone out
there might already know the answer so I don't have to dig through all
those kernel sources. I'm trying to get my Ericsson R380s phone to
talk to my Pismo PowerBook. For some reason it plainly does not
work. I cannot be configuring wrong all that IrDA protocol stuff, so
there must be something fundamentally wrong. I suppose IrCOMM only
supports SIRs emulating the 16550A serial chip, and from the kernel
log one can notice that the PowerBook seems to utilize Z8530 chips
which I suppose is a different thing altogether.  Can I just snatch
some Z8530 code from other driver sources, e.g. the stuff for the old
TurboChannel DECstations which used this chip for their keyboard
etc. i/o?  I'm just running quite short on time, since this is really
needed for the CEO of our company, since I persuaded him to get a
PowerBook to run Linux on... sheesh.

Now, anyone who has succesfully got any IrDA devices to work with the
PowerBook IrDA port? any suggestions?

-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
