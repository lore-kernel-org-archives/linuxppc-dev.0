From: "T Michael Turney" <tmike@recipes4linux.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: FEC support for 8260 in kernel 2.4.25
Date: Fri, 23 Apr 2004 16:23:37 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHGEDNCJAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,
This is my first posting on this list.

I am working on a kernel port to an 8260 board that
has all three FCCs wired up to PHYs (BCM5221).

The first FCC is working fine, but I haven't been
successful with getting FCC2 and FCC3 going yet.

Is anybody out there successfully using the 2.4.x
fcc_enet.c code with all three channels active?

Cheers,
T.mike

Tools Made Tough
Project Consultant
(o) 760.728.5401
(c) 760.415.8792

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
