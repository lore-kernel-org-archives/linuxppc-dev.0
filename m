To: linuxppc-embedded@lists.linuxppc.org
Subject: Microcode patching
Message-ID: <1036764594.3dcbc5b26bd42@imp.imms.de>
Date: Fri, 08 Nov 2002 15:09:54 +0100 (MET)
From: Christian Schroeder <christian.schroeder@imms.de>
Cc: reklies@mazet.de, linz@mazet.de
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've got a question regarding the mpc8xx microcode patches in
arch/ppc/8xx_io/micropatch.c. We do need usb host mode, i2c and
ethernet operation at the same time. As I understood, i can't load
the microcode patches for usb sof generation and iic/spi together,
because they "live" at the same address. Now my question: What occurs
if I don't load the ii2/spi patch. I do need the usb sof timing, but
does the i2c-Interface work without the iic/spi patch ? As I read on
the motorola webserver, the iic/spi is needed for concurrent operation
of scc ethernet and i2c. Does i2c work correctly without the patch if
I don't use ethernet ?

Greetings
Christian Schroeder

Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
         christian.schroeder.ik@gmx.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
