From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBDF7@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: jjboor@sun023.aimsys.nl
Subject: About MTD.
Date: Wed, 11 Jun 2003 14:45:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am trying to use MTD on my board.

I have two flash AMD LV160BB that are configured in 16 bits.

They are in parallel so I have got a 32 bits bus wide.

Each flash is 2 Mo . So the total is 4 Mo.

My flash starts at @ : 0x04000000.

So in the configuration for Linux I set
	CFI : yes
	Start @ : 0x04000000
	Size : 0x00400000
	Bus Width : 4

The result at the boot is :

physmap flash device: 400000 at 4000000
 Amd/Fujitsu Extended Query Table v1.0 at 0x0040
number of JEDEC chips: 1
0: offset=0x0,size=0x8000,blocks=1
1: offset=0x8000,size=0x4000,blocks=2
2: offset=0x10000,size=0x10000,blocks=1
3: offset=0x20000,size=0x20000,blocks=31
mtd: Giving out device 0 to Physically mapped flash

Is it correct ?
Why is there only one JEDEC Chip detected ?

Regards

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
