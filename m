From: ajay.kunnath@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786011B7913@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Help with MPC port
Date: Mon, 17 Jul 2000 09:07:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to get linux 2.2.13 from montavista running on a
proprietary MPC860 board.

I loaded the kernel into the RAM using MPCbug. On running it, it
crashed in the early instructions of serial_init. I have hardcoded
the board_info values in the mbxboot/head.S file as local_bd_info.

I noticed in the m8xx_tty.c that the first few lines of code try to
access the structure immap_t. But, who initializes these structures ?
Is it the EPPCbug of MBX ? If so, how do I go about doing similar
thing on my proprietary board ?


Thanks,
Ajay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
