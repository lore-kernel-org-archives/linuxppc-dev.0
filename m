Message-ID: <BE684E2C997AD51199530002A56B20790661EE@MCHH2A1E>
From: Babic Stefano <Stefano.Babic@icn.siemens.de>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE:64 bit Flash driver
Date: Mon, 22 Oct 2001 15:11:27 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ofer,

officially in the MTD supplied with 2.4 Kernel there is no support (at least, the version I have) for 64 bit bus, but in the archive of the mailing list there is the suggestions to support it.
I have applied it on my system (I have a MPC 755 with a 8260 as slave, 64 bit bus).
Then you can also set the JFFS or another FS on top of it (I am using JFFS).

You can find it at :

http://www.linux-mtd.infradead.org/ <http://www.linux-mtd.infradead.org/>

and the archive at http://lists.infradead.org/pipermail/linux-mtd/ <http://lists.infradead.org/pipermail/linux-mtd/> .

I hope this can help

Stefano babic
Stefano.babic@icn.siemens.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
