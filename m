Message-ID: <000701c160c3$1465f540$23d9b5d4@jocke>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <kd@flaga.is>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE:CPM interrupts raised to early? (was More I2C stuff,) 
Date: Mon, 29 Oct 2001 22:45:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kari

This rings a bell in my mind. There is(was?) a line early in the irq routine
where i2cmod(?) is disabled(there is a comment that states that this is
due to some chip errata).

First a commeted this line and my I2C was starting to work. Later
I moved it to someplace directly after IRQ context and now my I2C is
working fine. Do you know what this "chip errata" referes to? I could
not find any reference to this in any Motorola doc.

If you want, I can send you my version of the i2c-algo-8xx.c driver(I am at
home
now and don't have access to the driver now)

   Regards
               Joakim Tjernlund
PS.
      I am also using motorola I2C microcode patch


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
