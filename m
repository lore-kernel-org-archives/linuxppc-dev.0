Message-ID: <399810EF.84798682@sharp.fm>
Date: Mon, 14 Aug 2000 17:31:59 +0200
From: Graham Leggett <minfrin@sharp.fm>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Stability problems with serial and sleep on Apple Powerbook
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am using v2.2.17pre13 of the Linux kernel available from
linuxcare.com.au, and I'm having some problems with the macserial driver
after waking up from sleep.

I have a 1999 Bronze G3 Powerbook, with a built in 56k modem, and IrDA
on ttyS0 and ttyS1. When the machine boots up, both the modem and the
IrDA work fine. If you put the machine to sleep and wake it up again,
the serial ports stop working. Attempts to connect to the ports just
either hang solid, or exit without the connect being successful.

In the case of minicom (and sometimes gnome-ppp) the application will
hang when you try and exit - as the closing of the serial port blocks
the machine.

Does anyone else have this behavior? The rebooting of my Linux system is
driving me nuts... anyone got a solution?

There are also USB problems after waking up from sleep, but I am not
100% sure it's the same problem. After waking up the mouse no longer
works. Unplugging then plugging the mouse back in fixes things.

Regards,
Graham
--
-----------------------------------------
minfrin@sharp.fm		"There's a moon
					over Bourbon Street
						tonight..."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
