Message-ID: <757A9CB222EBD5118D2300D0B7828DE10BE1D641@az33exm32.corp.mot.com>
From: Swarthout Ed-RA8734 <Ed.Swarthout@freescale.com>
To: "'DeLaGarza, Robert'" <robdlg@att.net>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8245 Error No. 26
Date: Tue, 27 Jul 2004 11:54:10 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Concurrent Write should never be set.  There was a problem with the autoconfig detection in serial.c which left this bit set in uart0 when detecting uart1.

See:
http://linux.bkbits.net:8080/linux-2.4/cset@3f95b003q4gnNPHPXqRMbNkI64jdaA?nav=index.html|src/|src/drivers|src/drivers/char|related/drivers/char/serial.c

I've verified this fix with the MPC8540 DUART.

Ed.Swarthout at Freescale dot com

-----Original Message-----
From: DeLaGarza, Robert

With regard to "Error No. 26" (quoted below), has any work been done in
the kernel or serial drivers to compensate for this error?

I've observed problems only when both UARTs were enabled, so I suppose
one solution is to enable only one UART.

...

http://www.freescale.com/files/32bit/doc/errata/MPC8245CE.pdf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
