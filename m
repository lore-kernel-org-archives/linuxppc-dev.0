To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: Support for new Dual G4 1 Gig machines?
References: <Pine.LNX.4.33.0201290949451.12240-100000@blues.wcg.mcgill.ca>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 29 Jan 2002 16:01:08 +0100
In-Reply-To: Christopher Murtagh's message of Tue, 29 Jan 2002 09:52:57 -0500 (EST)
Message-ID: <8xn0yxyzez.fsf@s61.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Apparently the GHz Macs use a new CPU variant, the MPC7455. It differs
very slightly from the earlier CPUs in that it has

 - a feature to lock parts of the L1 data cache (can probably be ignored)

 - some extra SPRGs (can probably be ignored)

 - 4 additional DBATs and 4 additional IBATs. I am not sure if those
   require initialization at early startup to not interfere with later
   operation.

The real difference is in fabrication; it is the first SOI part.

Some official info here (beware of line wrap):

http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7455&nodeId=03M943030450467M986

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
