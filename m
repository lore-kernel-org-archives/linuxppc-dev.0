From: NBLIST@sbcglobal.net
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <AA-0296B6B7975FF39FEDDBA26C4B9351E2-ZZ@homebase1.prodigy.net>
Date: Wed, 22 May 2002 20:00:10 -0500
Subject: ethernet works only the first time
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am using the fec on the MPC855T on my custom board.
I seem to be having some weird ethernet configuration
problems. My eth0 interface comes up only the first
time. If I "ifconfig down" the eth0 and bring it back
up by doing "ifconfig up", the eth0 interface shows up
fine. But ethernet doesnt work anymore. After a couple
of minutes, I get "tx buffer full" error messages. But
it always works the first time I boot the linux kernel
and bring up etho using ifconfig.

What's going on here? Any ideas, clues, tips????

Thank you,
NB


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
