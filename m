To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc8xx usb hci controller
Message-ID: <1024045073.3d09b0113c800@imp.imms.de>
Date: Fri, 14 Jun 2002 10:57:53 +0200 (MEST)
From: Christian Schroeder <christian.schroeder@imms.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi list,

I used the usbsample driver from the book "Linux Device Drivers" to
verify the m8xxhci driver (Brad Parker, rel. 2) for my TQM823L board
and succeded testing interrupt transfers between the mpc823e and a
usb mouse/keyboard.

Now I'm looking for a little test utility to verify bulk transfers.
Is there such a utility on the net or do I have to imlement it myself,
e.g. using libusb/usbutils ?

thanks very much.
Christian Schroeder

Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
