Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1499EDDFB4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 07:55:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [OT] write flash on MPC5200 board via jtag
Date: Tue, 22 Jul 2008 14:55:41 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D60249D937@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <1216753011l.5683l.0l@antares>
References: <1216753011l.5683l.0l@antares>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: =?iso-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	"LinuxPPC Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you don't have any code on the board then I can't think of how to =
write to the flash unless you have a JTAG device. I use a BDI2000 to do =
precisely what you're doing: write U-boot into virgin on-board flash on =
a design derived from the lite 5200.

The significance of the debugger is that you need something that can =
drive the microcontroller via the JTAG port and control the flash device =
write intricacies.

Pre-programming your flash device is another option.

-----Original Message-----
From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org] =
On Behalf Of Albrecht Dre=DF
Sent: Tuesday, July 22, 2008 1:57 PM
To: LinuxPPC Embedded
Subject: [OT] write flash on MPC5200 board via jtag

Hi,

sorry for a somewhat off-topic question...

I want to design a mpc5200b board which is roughly derived from =20
Freescale's 5200B Lite demo.  Obviously, I have the problem to =20
initially write u-boot into the boot nor flash.  I believe this would =20
be possible using the jtag/bsm interface (is that true?).

Can you recommend any good hardware and software solution for that, if =20
possible running on linux (OSS?)?  I don't need a "real" debugger =20
(maybe an interface to gdb), just something to write the flash, so =20
u-boot comes up.

Thanks for any help,
Albrecht.
