Message-ID: <4019681F012FDFDC@mta1.wss.scd.yahoo.com> (added by postmaster@mail.san.yahoo.com)
From: "Phil Shepard" <phil@artismicro.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Jumbo Frames and MPC8540
Date: Sun, 29 Feb 2004 10:56:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   I'm working with a MPC8540 trying to measure the performance of the built
in GigE.  I'm running 2.4.25 on the PPC.  On the other end is a Dell
Precision M60 laptop with it's Broadcom 5705 GigE Chip I'm running RH9 and
can't seem to get the MTU much larger than 1500.  I'd like to simply
transfer 8192 byte jumbo frames from the Dell to the MPC8540 running an echo
server.

Any suggestions?  Is there a better list for this type of question?

Phil
---------------------------------------
Phil Shepard
Applications Engineer
Artis Microsystems


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
