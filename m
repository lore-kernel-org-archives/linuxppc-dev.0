Message-ID: <000801c06595$5f102540$ef0fa8c0@hoangmobile>
From: "Nguyen Xuan Hoang" <jerry.nguyen@serialsystem.com.sg>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <support@mvista.com>
References: <3A37867B.2070606@galileo.co.il>
Subject: PCMCIA have machine check
Date: Wed, 13 Dec 2000 22:16:18 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to run Wireless Lan PCMCIA on RPXLite board,  but the system
just randomly crash (a machine check error).  I have trace the error, it
happen when we read or write the I/O port on the wireless LAN. It seems the
PCMCIA controller not set correctly. Have anyone experience about this
problem, please give me some advice.

Thank in advance
Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
