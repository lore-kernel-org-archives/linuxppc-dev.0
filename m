Date: Tue, 12 Feb 02 22:59:30 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0202130659.AA16839@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: I'm no longer at SBS + my GT-64260 stuff
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux/PPC developers,

In the past I had supported Linux on certain PPC boards made by SBS, and I had
also talked on this mailing list to some extent about StarMON, an IMHO
wonderful ROM monitor of my invention, both for SBS and for the world. Well,
there have been some changes, specifically I no longer work for SBS effective
today (involuntarily so, job leads welcome :), and therefore I can no longer
speak for SBS. I do not personally own any of their hardware, so unfortunately
further contributions from me to code for their boards are very unlikely.

As for StarMON, I thought I would make it see the light of day by making a
version of it for a non-SBS board in the public domain. (As I understand it SBS
has got rid of StarMON together with me.) That non-SBS board is Marvell/
Galileo's reference board for the GT-64260A system controller, the EV-64260A.
Only 750 family CPUs are supported, not 74xx. The code can be obtained from the
IFCTF CVS with:

cvs -d :pserver:anoncvs@ivan.Harhan.ORG:/fs3/IFCTF-cvs co ppcstar-ref-impl \
	starboot starboot-drivers starmon-tools ppc-linux-boot

It's not release quality, but I thought I would release what I have as right
now I'm not likely to improve it because again I didn't personally own the
hardware and no longer have it.

You can also get all my public domain Linux/PPC work that never made it into
the public tree with:

cvs -d :pserver:anoncvs@ivan.Harhan.ORG:/fs3/IFCTF-cvs co linuxppc-mikes-diff

It's a diff against linuxppc_2_4_devel. Apart from the stuff I've posted here
before that wasn't incorporated into the public tree, the new stuff you haven't
seen before is my GT-64260 work. I've made some pretty good improvements IMHO
to that code, so check it out.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
