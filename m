Message-ID: <000d01c2e6c2$621e1de0$af85efcb@qhavm>
From: "Q-ha Park" <qhpark@jchyun.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel stops after the msg, "Now booting the kernel"
Date: Mon, 10 Mar 2003 14:03:15 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been using the kernel 2.4.17 for redwood5 from montavista. recently, I tried to use the 2.4.21-pre5 kernel, but it stops right after the msg: "Now booting the kernel".
----------------
Loading file "vmlinux.tree.img" by TFTP for net boot ...
Transfer completed, 890912 bytes received
Loaded successfully ...
Entry point at 0x500000 ...

loaded at:     00500000 005DB1F8
relocated to:  00400000 004DB1F8
board data at: 004D8128 004D8168
relocated to:  00405278 004052B8
zimage at:     00405800 004D719E
avail ram:     004DC000 02000000

Linux/PPC load: console=ttyS0,115200
Uncompressing Linux...done.
Now booting the kerne
<stopped>

any ideas?

thanks in advance.

---------------
Q-ha Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
