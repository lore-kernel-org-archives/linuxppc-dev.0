Date: Sun, 28 Apr 2002 21:59:49 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: Aurel Wisse <aurel_wisse@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	yddev <yellowdog-devel@lists.terrasoftsolutions.com>
Subject: Re: Sungem with iMac Rev-B
In-Reply-To: <20020429004945.83544.qmail@web14804.mail.yahoo.com>
Message-ID: <Pine.LNX.3.96.1020428214410.11407D-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 Apr 2002, Aurel Wisse wrote:

> I am trying to modify the bmac to force the PHY to
> abandon autonegotiation and to use 10Mb/s and half
> duplex. "Reverse engineering" the bmac code leads
> nowhere. The bmac_init_phy doesn't give a lot of info,
> except a couple of undocumented constants written via
> bmac_mif_write, and the mif_write writes to the MIFCSR
> register which is undocumented in the bmac.h file.
>
> This is terribly frustrating as Apple is obviously
> able to do it with their Duplex tool hack. Hence, it
> *can* be done. Why can't they just send us their
> sourcecode for the Duplex tool? Does anybody have a
> direct line to Apple?

Looked at the Darwin sources lately?  BMacEnet::miiInitializePHY appears
to describe the "normal" setup in a way that should make it pretty obvious
how to set it up in non-normal ways -- or perhaps not -- I've never dealt
with the chip, personally -- but it's a good starting point, anyway.


Later,
David

---------------------------------------------------------------------
David A. Gatwood                                dgatwood@gatwood.net
Developer Docs Writer                             dgatwood@apple.com
Apple Computer                                  dgatwood@mklinux.org

                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
