From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15289.61816.759663.863700@igor.jsc.nasa.gov>
Date: Tue, 2 Oct 2001 11:55:20 -0500
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: building tools from montavista SRPMs
In-Reply-To: <3BB9ED05.D354AF5B@midrivers.com>
References: <3BB9ED05.D354AF5B@midrivers.com>
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon writes:
 > I've seen references to 'rpmconfig' but don't know just what to
 > feed rpm / rpmconfig in order to build per the SRPM spec files.

You need to install the hhl-host-rpmconfig RPM (something like
hhl-host-rpmconfig-1.98-hhl2.0.1.i386.rpm)  Then follow the
instructions in /opt/hardhat/config/rpm/README.

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
