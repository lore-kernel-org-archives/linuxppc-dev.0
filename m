Message-ID: <018601bfc7e6$30ab9560$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <greyham@research.canon.com.au>, <ddickey@charter.net>
Subject: NFS problem- neighbout table overlow
Date: Tue, 26 Sep 2000 15:20:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Everyone,

I have been having problems with my custom board. The NFS mount does not
work. The NFS request does not actually go the server. I dont see any
packets coming to the server from this board. I did have some ring dump
problems. There were some errors in Port A setting which I fixed and that is
gone now. By I still see 'neighbour table overflow' messages. What can be
the problem?

lcd_lcsr: 0
lcd_lcfaa: 100000
lcd_lchcr: 1814000
lcd_lcvcr: 78000
loop: registered device at major 7
eth0: CPM ENET Version 0.2, 08:00:22:50:70:63
PPP: version 2.3.10 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Looking up port of RPC 100003/2 on 216.118.31.75
neighbour table overflow
neighbour table overflow
neighbour table overflow


Navin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
