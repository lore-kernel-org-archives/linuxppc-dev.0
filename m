Message-ID: <39B2DAB5.A276490@ncal.verio.com>
Date: Sun, 03 Sep 2000 16:11:49 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, iain@sandoe.co.uk
Subject: AWACS rev 3 [screamer] Byte Swapping
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've had a chance to try Iain's stest routines on
an SMP G4. It is also exhibiting the same inability
to play LE data as the Pismo. So, has anyone had any
success with playing LE data on any Core99 machine?
Or any other that reports it has an AWACS rev 3 sound
chip (see /dev/sndstat)? And by this, I mean using
a player that does not swap LE bytes to NE before
sending it to the sound device (e.g. Iain's stest
or xmms with the OSS output plugin).

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
