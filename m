Date: Thu, 13 Jul 2000 07:16:10 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Recent controlfb.c change in BK's linuxppc_2_3
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000713071025.18408B-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've just noticed that the function, control_vram_reqd() was renamed to
control_vram_read() in BK tree.  The function is supposed to calculate the
amound of VRAM required for given vmode and cmode.  That's why it was
named that *_reqd().  AFAICS, *_read() naming has no meaning and
misleading.  Please change it back or rename it to something better.


Thanks,

Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
