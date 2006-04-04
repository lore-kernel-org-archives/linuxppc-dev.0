Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id C671A67A44
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 12:16:29 +1000 (EST)
Date: 4 Apr 2006 02:09:46 -0000
Message-ID: <20060404020946.19378.qmail@kunk.qbjnet.com>
To: linuxppc-dev@ozlabs.org
From: "Bob Brose" <linuxppcdev@qbjnet.com>
Subject: platinumfb broken in 2.6.16
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Worked in 2.6.14:
platinumfb: Found Apple Platinum video hardware
platinumfb: Total VRAM = 2MB (0011)
platinumfb: DACula type 0x3c
platinumfb: Monitor sense value = 0x62b, platinumfb:  Using video mode 6 and col
or mode 2.
line_length: a20
Console: switching to colour frame buffer device 80x30
fb0: Apple Platinum frame buffer device
Macintosh non-volatile memory driver v1.1

This is all I get in 2.6.16:
Platinumfb: Found Apple Platinum video hardware
Macintosh non-volatile memory driver v1.1

The screen has the boot params on it but is otherwise blank.
Everything else works as normal.
