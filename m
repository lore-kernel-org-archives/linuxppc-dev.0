Message-ID: <011201c12519$94d06520$2408a8c0@dnaent.com>
From: "William H. Short, Jr." <bshort@dna-cs.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: yellowfin.c problems after LK1.1.3 added
Date: Tue, 14 Aug 2001 18:33:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This driver was working fine with the 53c885 combo chip before the lastest
mods has anyone else tried it out?
Now this driver will transmit but all receive packets are erroring out.  If
no one else has tried it, I might get a chance tomorrow to look into it;
however, ncr885e.c will work.  If it works for the 83c8xx series people,
I'll just switch over.
Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
