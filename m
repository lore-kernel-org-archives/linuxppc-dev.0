Mime-Version: 1.0
Message-Id: <v04220800b4db5bdc17bf@[10.0.0.42]>
In-Reply-To: <20000224121210.030675@mailhost.mipsys.com>
References: <20000224121210.030675@mailhost.mipsys.com>
Date: Thu, 24 Feb 2000 14:13:41 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PCI I/O address problems on B&W G3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:12 PM +0100 2/24/00, Benjamin Herrenschmidt wrote:

>The fact that they are at fe000000 seems to indicate that the io base
>address is 0 (and so was apparently _not_ assigned at all). Could you
>break into OF, dev to those devices, and send me the output of
>.properties ? (I need the content of the "reg" and "assigned addresses"
>properties). I want to see what OF did with the cards exactly.


/dev/pci/pci-bridge/ADPT,2940UW@3

reg:
00011800 00000000 00000000 00000000 00000000
02011814 00000000 00000000 00000000 00000100
02011830 00000000 00000000 00000000 00010000

assigned addresses:
82011830 00000000 80890000 00000000 00010000
82011814 00000000 80884000 00000000 00001000


/dev/pci/pci-bridge/ADPT,39160@4

reg:
00012000 00000000 00000000 00000000 00000000
03012014 00000000 00000000 00000000 00001000
02012030 00000000 00000000 00000000 00020000

assigned addresses:
82012030 00000000 80900000 00000000 00020000
83012014 00000000 80883000 00000000 00001000


/dev/pci/pci-bridge/ADPT,39160@4,1

reg:
00012100 00000000 00000000 00000000 00000000
03012114 00000000 00000000 00000000 00001000
02012130 00000000 00000000 00000000 00020000

assigned addresses:
82012130 00000000 808e0000 00000000 00020000
83012114 00000000 80882000 00000000 00001000

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
