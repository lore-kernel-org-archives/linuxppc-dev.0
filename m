Message-ID: <000701c10025$0e91a320$c497143e@jocke>
From: "Tjernlund" <tjernlund@telia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Power on startup problem
Date: Fri, 29 Jun 2001 00:52:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

My custom MPC860 board does not start at power on. All that
 happens is that the SW Watchdog resets the system after 5 seconds.

But if I connect my Abatron BDI2000 emulator with a stripped config file
that don't initialize any registers and type go at the telnet prompt
everything
is OK.

I am running PPCboot from Intel flash. The board has a 5MHz clock source and
is multiplied to 25 MHz during powerup.

Another problem,possibly related, is that I am unable to run the CPU at
higher
speeds than 40 MHz(and yes I run the bus at half CPU speed). According
to the emulator I get a external reset when I run at higher speeds.

Any pointers are most welcome :-)

  Joakim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
