Content-Type: text/plain;
  charset="iso-8859-1"
From: jim <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Delay on starting init
Date: Wed, 11 Sep 2002 12:34:54 +0000
MIME-Version: 1.0
Message-Id: <20020911175118.04A9E38E9D@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I pulled the lastest 2.4 devel tree from Monte Vista's mirror a couple of
days ago and the behaviour of the boot process changed.  Now, the process
pauses for a long time after the message; "Freeing unused kernel memory".  To
make sure this was a kernel issue, I reverted to the previous kernel and it
booted with no delay.  Also, the delay is apparent on both Hard Hat Linux 2.0
and ELDK from Denx.

Is anyone aware of what changed?

Thanks,
Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
