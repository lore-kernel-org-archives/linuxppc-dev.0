Date: Thu, 7 Dec 2000 12:11:07 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.5 or 2.4 kernel profiling
In-Reply-To: <Pine.GSO.4.21.0012071148420.515-100000@eos>
Message-ID: <Pine.GSO.4.21.0012071210280.515-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to do some kernel profiling on my EST8260 to determine the
bottle neck in TCP and UDP thruput, but I can't seem to get any profile
information.

I have put "profile=2" on the kernel boot line, and readprofile -i
confirms this, but no function info shows up.  Is this known to be broken,
or have I just not figured out the magic combination yet?

Thanks.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
