Message-ID: <B25E2E5A003CD311B61E00902778AF2A039C3E40@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Sometimes serial port seems stuck.
Date: Wed, 19 Jun 2002 09:12:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a custom 8xx board. I am using SMC1 for serial port. SCC1, SCC2 for
Ethernet.
Using ppcboot as bootrom & linux 2.4.1

What I have observed is sometimes output on serial port gets stuck, i.e. I
don't see any output
unless I hit enter. I have tried executing "reset" UNIX command and it
doesn't help.

Has anybody seen this before and what might be the cause & remedy for this?

Subodh Nijsure
Software Manager - Network Media Routers
SkyStream Networks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
