Date: Tue, 28 Oct 2003 16:59:49 -0600
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Video mirroring with radeon mobility 9600
From: Ken Offer <koffer@arlut.utexas.edu>
To: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Message-Id: <6EA3E629-099A-11D8-B1A5-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Anyone out there had any luck getting video mirroring to work on the
2003 15" PowerBook?

My modified 2.4 kernel won't mirror.
I've tried the latest radeon driver from the 2.6 kernel and I can't get
it to work either.

The yaconf boot parameters I used under the 2.6 were:

	append="hdc=ide-scsi video=radeonfb:dfp,mirror"

I hooked up a flat-screen monitor to the laptop via a digital-to-vga
cable.  When mirroring is suppose to come on, I get something which
looks like Open-Firmware text on the other monitor.

I've tried modifying m3mirror to access the radeon driver.  It appears
to turn the lcd and crt displays on and off, but it still doesn't
mirror.  I'm still stuck with the OpenFirmware display.

I'm thinking something must be different about mirroring in the
mobility chips which isn't accounted for in the radeon driver.

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
