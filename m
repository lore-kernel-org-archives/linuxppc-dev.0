From: "Steve Clarke" <steve.clarke@overturenetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA on MBX860
Date: Sat, 3 Feb 2001 13:34:07 -0500
Message-ID: <HCELKHHHIOJIDLBGAKBCKECFCAAA.steve.clarke@overturenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like to get PCMCIA working on an MBX860 running HardHat. There was a
thread in Nov 2000 on this topic between Paul Ruhland and Matthew Locke.
Based on this thread, I started with pcmcia-cs-3.1.24.

However, in 3.1.24 m8xx_pcmcia.c does not have references to the MBX board.
It supports RPXxxx, ADS and FADS. Paul's email on 11-21-2000 said that he
made MBX specific changes. Are these changes publicly available? If so, how
do I get these changes?

thanks,
stevec
-----------------------------------
Steve Clarke
Overture Networks
(919) 558-2200


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
