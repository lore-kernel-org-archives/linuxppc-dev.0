Subject: RE: System crash in kernel_thread 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 3 Jun 2003 12:17:30 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED702FB8F@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> It is still there with a BDI start.

I experienced a similar problem with my 860 based board.
The solution was in DER (Debug Enable Register) configured by the BDI.
I had to remove a bit, I just don't remember which one.

--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
