To: linuxppc-dev@lists.linuxppc.org
Subject: iMac DV, Linux 2.2.17pre7 and sound
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: 07 Jul 2000 12:02:34 +0200
Message-ID: <m3bt0ai7gl.fsf@quimbies.gnus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Using the current linux-pmac-stable on my iMac DV, pretty much
everything works except that I can't get any sound out of the
speakers.  I get sound out the headphone jacks, and sound out the line
out jack, but the speakers are silent.

sndvolmix segfaults in the busy_wait function -- when doing the
ld_rev(&awacs[4]) check, in fact.  Perhaps the iMac DV has a different
awacs layout?  Is there anything I can do to help debug this?

--
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
