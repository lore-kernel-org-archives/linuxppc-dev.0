Message-Id: <200206171543.g5HFh3W08124@p2.parker.boston.ma.us>
To: Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx usb hci controller 
In-Reply-To: Message from Christian Schroeder <christian.schroeder@imms.de>
   of "Fri, 14 Jun 2002 10:57:53 +0200." <1024045073.3d09b0113c800@imp.imms.de>
Date: Mon, 17 Jun 2002 11:43:03 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There was a little usb transfer test program which would download code into
an EZ-USB chip (I used a keyspan serial converter :-)

It will test interrupt, iso & bulk to some extent.  I've been hacking
it a little now and then.  It was called "usbstress".  I last saw the
version # as 0.3.  I've since created a 0.4 version

If you like I can put it up for ftp.

-brad

Christian Schroeder wrote:
>
>Hi list,
>
>I used the usbsample driver from the book "Linux Device Drivers" to
>verify the m8xxhci driver (Brad Parker, rel. 2) for my TQM823L board
>and succeded testing interrupt transfers between the mpc823e and a
>usb mouse/keyboard.
>
>Now I'm looking for a little test utility to verify bulk transfers.
>Is there such a utility on the net or do I have to imlement it myself,
>e.g. using libusb/usbutils ?
>
>thanks very much.
>Christian Schroeder
>
>Dr.-Ing. Christian Schroeder
>Institut fuer Mikroelektronik- und Mechatronik-Systeme
>Langewiesener Strasse 22
>98693 Ilmenau
>Telefon: +49 3677 678315
>Telefax: +49 3677 678337
>Mobil:   +49 173 5789172
>e-mail:  christian.schroeder@imms.de
>www:     http://www.imms.de/~christi/cs.html
>pgp:     finger christi@finger.imms.de
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
