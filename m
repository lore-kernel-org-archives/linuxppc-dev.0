Message-ID: <20010818012810.26415.qmail@kunk.jriver.com>
Subject: Re: Occasional crash reports
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 17 Aug 2001 20:28:10 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-- forwarded message --
From: mfedyk@matchmail.com (Mike Fedyk)
Subject: Re: Occasional crash reports
On Mon, Aug 13, 2001 at 09:59:05PM -0500, Takashi Oe wrote:
>
> I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
> are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
> rather easily with regular programs, given a day or two.  I have not seen
> similar instability on other machines (dual g4, 7600, all nubus).
> Unfortunately, I don't have any time to track it down right now  :(

I've been able to trace that to the mace and bmac ethernet drivers, which
are *very* unreliable in 2.2.  Get the latest drivers from Donald Becker for
tulip, rtl8139, eepro100, etc. and you're set.  I haven't tried 2.4 yet.

Mike
-- end of forwarded message --

Mace is still unreliable in 2.4. It's always been just plain unreliable
for me on 7200, 7500 and 7600's. It's a bummer because it sure
would be nice to have another PCI slot free. Tulip works well as does
ne2k-pci.

Bmac has given me problems on a rev C imac. I've almost given up on
the iMac because yaboot seems unable to handle booting partition 13 which
is about 30 gigs up into a 45 gig drive. I can only get at it by using
bootx on a 8.6 CD (the iMac os is 9.1).

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

----- End of forwarded message from Robert E Brose II -----

--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
