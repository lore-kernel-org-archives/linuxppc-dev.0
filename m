Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id C0AFD2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 17:48:47 +1000 (EST)
Message-ID: <51DB8827D393D411BB69003048003F46FDCF2A@tvesntr.televes.com>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 13 Oct 2004 09:46:16 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: 
Subject: bridge, promiscous mode andcpm2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks (After some days of holydays).

Now, promiscous mode works fine, so board is bridging ok.

Best regards,

Alex


-----Original Message-----
From:	Rune Torgersen [SMTP:runet@innovsys.com]
Sent:	Friday, October 08, 2004 4:02 PM
To:	alebas@televes.com
Cc:	linuxppc-embedded@ozlabs.org
Subject:	RE: Bridge, promiscous mode andCPM2

Hi

Assuming CPM2 => 82xx or 85xx CPU.

In the old 8260_io/fcc_enet.c	the set_multicast_list 
function is present, bu has an early return nine lines 
in. If you delete that return, promiscous mode works great.

I have no idea who or why that early return was put in, 
but it does disable multicast and promiscous mode 
on the FCC ethernets.
