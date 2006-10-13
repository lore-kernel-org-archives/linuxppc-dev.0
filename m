Return-Path: <rcorley@aegis-inc.net>
Received: from web56302.mail.re3.yahoo.com (web56302.mail.re3.yahoo.com
	[216.252.110.226]) by ozlabs.org (Postfix) with SMTP id 1AF3667C68
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 02:05:49 +1000 (EST)
Message-ID: <20061013155908.4944.qmail@web56302.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 08:59:08 -0700 (PDT)
From: Robert Corley <rcorley@aegis-inc.net>
Subject: which driver for uartlite with 2.6.17?
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,=0A=0ABased on what was posted recently, it appears that there is more =
than one uartlite driver =0Afloating about.=0A=0ACan someone please inform =
me of which driver works for which kernel?=0A=0AHere is what I see=0A=0AD. =
Lynch    2.6.15    polled, (Pico E12 board specific?)=0AP. Korsgaard    2.6=
.18    interrupt driven, official lanana.org nodes=0AD. Bolcsfoldi    2.6.1=
8    interrupt driven=0A=0Apatch locations:=0AD. Lynch    http://ozlabs.org=
/pipermail/linuxppc-embedded/2006-January/021592.html=0AP. Korsgaard    htt=
p://lkml.org/lkml/2006/9/13/71=0AD. Bolcsfoldi    http://ozlabs.org/piperma=
il/linuxppc-embedded/2006-October/024697.html=0A=0AComments?=0A=0AAnd, last=
ly, I need a driver for 2.6.17.  Can someone point me in the right directio=
n?  =0AI have tried Peter's driver but it fails to compile, showing this:=
=0A=0ACC      drivers/serial/serial_core.o=0ACC      drivers/serial/uartlit=
e.o=0Adrivers/serial/uartlite.c: In function `ulite_startup':=0Adrivers/ser=
ial/uartlite.c:199: error: `IRQF_DISABLED' undeclared (first use in this fu=
nction)=0Adrivers/serial/uartlite.c:199: error: (Each undeclared identifier=
 is reported only once=0Adrivers/serial/uartlite.c:199: error: for each fun=
ction it appears in.)=0Adrivers/serial/uartlite.c:199: error: `IRQF_SAMPLE_=
RANDOM' undeclared (first use in this function)=0Amake[2]: *** [drivers/ser=
ial/uartlite.o] Error 1=0Amake[1]: *** [drivers/serial] Error 2=0Amake: ***=
 [drivers] Error 2=0A=0A=0A=0A
