Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204433C@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Abatron BDI2000
Date: Tue, 30 Jan 2001 14:42:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone out there using the Abatron BDI2000 to set hardware breakpoints on
data access (on 405GP)? I'm probably just doing something dumb, but I don't
see it. Any ideas?

Thanks,

Brian

BDI>bd w 0xc019c390
# syntax is BDx [R|W]
BDI>bdx w 0xc019c390
# syntax error in command
BDI>bd w c019c390
# syntax error in command
BDI>bd 0xc019c390
# syntax is BDx [R|W]
BDI>BD W 0xc019c390
# syntax is BDx [R|W]
BDI>BDH W 0xc019c390
# syntax is BDx [R|W]
BDI>bd0 w 0xc019c390
# syntax error in command
BDI>bd4 w 0xc019c390
# syntax error in command
BDI>bdw w 0xc019c390
# syntax error in command
BDI>bd r 0xc019c390
# syntax is BDx [R|W]
BDI>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
