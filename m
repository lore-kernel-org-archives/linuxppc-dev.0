Message-ID: <4016907D.3070901@euronet.nl>
Date: Tue, 27 Jan 2004 17:23:25 +0100
From: Jos Beck <jos.beck@euronet.nl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8xx SCC for sync. HDLC on 2.4 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to build a synchronous HDLC driver for the SCC of the MPC850/860
under linux kernel 2.4.22

I have got one working on a 2.2.5 kernel and one buggy, async only, for the 2.4
kernels.
What would be the best approach: porting the 2.2.5 driver to the 2.4.x kernel or
digging into the driver (ehdlc.c by Rodolfo Giometti based on Dan Malek's
enet.c) to make it work for sync HDLC at high speeds?

Or an alternative?


Best regards,

Jos Beck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
