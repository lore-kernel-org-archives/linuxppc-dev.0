Date: Tue, 22 Apr 2003 18:55:59 +0200 (CEST)
From: Samuel Ortiz <samuel.ortiz@smartdata.ch>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc405 IDE interface
Message-ID: <Pine.LNX.4.44.0304221831530.570-100000@jourdain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,

I'm currently working on a stb03xx ppc405 based IBM board, and I'm trying
to get the IDE interface working.
I'm using a montavista 2.4.17 kernel in order to read to and write from a
Compact Flash card connected to the ppc405 IDE interface.

I just compiled the kernel with CONFIG_BLK_DEV_IDEDISK and
CONFIG_BLK_DEV_REDWOOD_IDE enabled. Unfortunately, this doesn't seem to be
appropriate. I can mount my Compact Flash card, copy stuff to it, but bad
things happen when I try to read it. I actually get the following messages :


  hda:hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
  hda: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=5, sector=5


repeated indefinitely (it can be from sector 0 to the end of the device).

Before you asked, I tried to do the same thing with a PC, and everything
went fine.

So, can someone tell me if they experienced the same problem when trying
to access an IDE device with a stb03xx board ?
Can somebody give me some hints ? Is there something obvious I'm doing
wrong ?

Any help is greatly appreciated.

Thanks in advance,
Samuel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
