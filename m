Message-ID: <BE1C564723B3D21191FD0000F840E39801D814CA@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Console serial output: what am I missing?
Date: Mon, 24 Apr 2000 11:21:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When booting Linux on my custom 860-based board, I get stuck in
serial_console_write where BD_SC_READY never goes low,
on the second iteration of the loop, first time the function is called.
It seems obvious that I haven't set everything up right:  the first
character is always pending and never finishes.  Can anyone loan me a clue
as to what might be missing?  I have set the board information including
bi_intfreq (50) and bi_baudrate (9600), and these values indeed are used by
m8xx_cpm_setbrg.  The uart.c is configured to use SMC1 as the console.
--
Dave Brown <dbrown03@harris.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
