Message-Id: <m12a0Ki-001SyRC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Connecting A/D and D/A to SCC channels on a MPC860/MPC8260
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 28 Mar 2000 13:03:16 -0500 (EST)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	* I am looking to connect serial A/D's and D/A's to one or more of
	the MPC860/MPC8260 SCC channels.  I will be working on a Linux
	device driver to support this hardware.  Has anybody worked on
	something like this before?  If so, would they be willing to share
	ideas, pitfalls, sample code, etc?

	Target hardware:

	48-96 Khz sampling
	22-24 bit

	Input:  4 A/D's
	Output: 2 D/A's

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
