Message-ID: <D53137D1F3DDD211A3750800060DA3130149DA67@viee122a.erd.siemens.at>
From: Grubmair Peter <peter.grubmair@siemens.at>
To: "'Julia Elbert'" <jelbert@enerdyne.com>
Cc: "'linuxppc-embedded post'" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: uart.c and scc2
Date: Mon, 27 Nov 2000 18:31:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have a patch for 2.2.14 at MPC850, which
supports RTS/CTS flow control, allows reordering
of SCC in rs_table (that means you can assign ttySx to
every SMC/SCC) and allows to configure more buffer for
SCC uarts ( 4 kB for receive, 8kB for transmit),
and is tested for baudrates up to (including) 460800 kBaud.
Additionally buffer_flush for these extended buffers is implemented,
and uarts can also operate in 8x oversampling mode, which is preferable for
some bad combinations of clock frequency and baudrate.
But as I need SCC uarts only for MPC850, I did code it  for other MPC8xx,
nor did I implement other features like DCD and other modem stuff.
If youe are interested, I can give it to you, but be aware its only
an implementation for special needs and is not fully tested
(e.g it crashes if on other side of line hw is sending at full speed
while you open  ttySx).
Best regards
                Peter
-----Ursprüngliche Nachricht-----
Von: Julia Elbert [mailto:jelbert@enerdyne.com]
Gesendet am: Montag, 27. November 2000 17:43
An: 'linuxppc-embedded@lists.linuxppc.org'
Betreff: uart.c and scc2


Does anyone know the status of scc2 in uart.c?
How far is it from working?

Very much appreciated.
--Julia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
