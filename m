Message-ID: <3CBF331B.EFBDCB92@esteem.com>
Date: Thu, 18 Apr 2002 13:56:59 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: boehringer@snom.de
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: pcmcia BCSRs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Sven,

Just figured out what you were refering to.

Our board has no BCSRs we have everything hard wired for the pcmcia.
No buffers, No latches, No registers  etc...  We just use pull up and
pull down resisters and have commented/hacked out the code used to
talk to the BCSRs.

sory for the misunderstanding,

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
