Message-ID: <E1836A7F3557D311A14000805F9F36FC015188C2@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Weird IRQ messages
Date: Wed, 27 Feb 2002 14:57:00 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I am using the MPC823e Embedded Planet platform running HHL
kernel 2.2.14.

I am attempting to use external interrupt IRQ2# to initiate an I2C message
transfer. I have the application working but I am getting some strange
*timebase_interrupt()* messages and *IIC read complete but rbuf empty*
messages when I cause the interrupt while running the application code.
Would anyone know what or why these are occurring?

The funny thing is that my I2C transfers are being performed flawlessly
within my application code!

I have been informed from Embedded Planet that external interrupt
IRQ2# is not used for anything else by the MPC823e PPC Software
Development Platform.

Regards,
     Michael Pergola
     Software Engineer
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
