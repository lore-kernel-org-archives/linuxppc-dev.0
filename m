Message-ID: <3BC3BC07.D6158215@carts.com>
Date: Tue, 09 Oct 2001 20:09:59 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 Communications Proccessor overload??
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   Has anyone ever run all 3 FCC ports at the same time with a
100Mbit link?  I think I'm seeing the Communications Processor get
overloaded, but Motorola claims there is no problem.  The setup is as
follows:  FCC1 is ftp-ing a very large file out (say 100MBytes).  FCC2
is
ftp-ing a very large file in.  FCC3 is being pinged at maximum rate by a
PC.
 What happens occasionally (like 1 out of 10 times) is that
the ping on FCC3 is not responded to in any manner.  A close examination
of
the Ethernet PHY (AM79C874) indicates no errors, but the MAC is
reporting
CRC errors.  I have captured the MAC --> PHY transfers on a logic
analyzer
and am decoding them at present (I hate computing a CRC-32 by hand).  I
was
hoping someone else has experience relative to this situation.

Thanks,

Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
