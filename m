Message-ID: <3C45A17E.24FC453B@ardistech.com>
Date: Wed, 16 Jan 2002 16:51:26 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC823e video dma priority?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have the video output of the 823e switching to the value in the video
background colour (VBCB) register when I have ethernet activity (on a EP
RPX Lite board with HH linux-2.4.2_hhl20). The LAM bit I have set and the
LAID and RAID are set to zero. Anybody knows why the SDMA apperently
can't fill the FIFO?

Best regards,
		Bart Thissen,	Ardis Technologies bv

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
