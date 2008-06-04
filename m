Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id DA43CDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 07:22:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Wed, 4 Jun 2008 15:22:31 -0600
In-Reply-To: <87tzg97f5l.fsf@macbook.be.48ers.dk>
References: <17222725.post@talk.nabble.com><20080514150139.E258D8D006F@mail70-va3.bigfish.com><17276753.post@talk.nabble.com><20080516162807.2132E181804D@mail89-sin.bigfish.com><17454696.post@talk.nabble.com>
	<17482754.post@talk.nabble.com><20080528140800
From: John Linn <John.Linn@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>,
	"swamydp" <swamydp@gmail.com>
Message-ID: <20080604212233.37F44130004F@mail123-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

Yes you need to enable UARTLITE as the console in the kernel
configuration.

You have the command line syntax, ttyUL0, correct.

They have now changed the UART 16550 to be a free core in the EDK, not
sure which version of the EDK that happened.

Thanks,
John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Peter Korsgaard
Sent: Wednesday, June 04, 2008 2:56 AM
To: swamydp
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board

>>>>> "swamydp" =3D=3D swamydp  <swamydp@gmail.com> writes:

 swamydp> Hi John

 swamydp> I am using UARTLITE as serial console. I do not have license
 swamydp> for UART 16550.  I have enabled the drivers for uartlite in
 swamydp> menuconfig while configuring the kernel. I have tested all
 swamydp> combinations for the kernel command line - tty0, ttyUL0,
 swamydp> ttyl0, ttyS0 but could not get uartlite to output kernel
 swamydp> printk messages.

Correct syntax is console=3DttyUL0

 swamydp> Since I am using uartlite , the following settings are
 swamydp> turned off in menuconfig

 swamydp> CONFIG_SERIAL_8250=3Dn
 swamydp> CONFIG_SERIAL_8250_CONSOLE=3Dn

Do you have console on uartlite (CONFIG_SERIAL_UARTLITE_CONSOLE)
enabled?

-- =

Bye, Peter Korsgaard
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
