To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC850: USB+SCC3_uart
Message-ID: <1043311470.3e2fab6e9e36b@imp.imms.de>
Date: Thu, 23 Jan 2003 09:44:30 +0100 (MET)
From: Christian Schroeder <christian.schroeder@imms.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello List,

we try to use the USB Controller (I think on SCC1) and the SCC3 uart
on a MPC850 simultaneously. We use Brad Parkres m8xxhci driver Rel. 2
for the usb part and Wolfgang Denk's kernel V 2.4.4-10-06-2002. But
the USB part and the SCC3 uart don't work together.

...
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 60k init
rh_port_reset(1)

... and the kernel freezes! The same thing occurs if we try to use SCC4
instead of SCC3. The kernel with only usb or scc uart works fine. Is there
any known reason, wich causes conflicts between usb and scc uart.

greetings
Christian

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
