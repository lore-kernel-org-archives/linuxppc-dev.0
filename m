Return-Path: <moises.dominguez@ctag.com>
Received: from jupiter.ctag.com (smtp.ctag.com [193.144.40.36])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95A77B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 20:14:59 +1100 (EST)
Received: from [193.144.40.38] (helo=INN0072)
	by jupiter.ctag.com with esmtpa (Exim 4.69)
	(envelope-from <moises.dominguez@ctag.com>) id 1PO4pg-0002vP-4Y
	for linuxppc-dev@lists.ozlabs.org; Thu, 02 Dec 2010 09:48:04 +0100
From: =?iso-8859-1?Q?CTAG_/_Mois=E9s_Dom=EDnguez?= <moises.dominguez@ctag.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 2 Dec 2010 09:48:03 +0100
Message-ID: <765B188B547A48E7951D86ACC3544C54@ctag>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem with MPC5121 custom board.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

We have a problem with custom design based on ads5121. May be you could
provide us any clue about what may be happening.

Sometimes, when the board is powered-on:

- U-boot does not start (at least serial port does not output anything, =
I
don't know if some piece of u-boot is executed).
- LPC_DIV and IPS_DIV are not configured so u-boot does not reach this =
point
either.
- The only way to get the board run once reached this point is power-off =
and
power-on again (That's: 3.3V, 1.8V. 1.4V).
- If we only turn-off 1.8V and 1.4V that's not enough to get the board
working.

When this happens we:

- Measured lpc_clock which is running at 33 MHZ so PLLs are working so =
reset
word is being read right.
- Measured all voltages (3.3V, 1.8V. 1.4V) and are OK.
- We read RCWL and RCWH with JTAG and have the value we expect.
- Could erase the flash with JTAG but we couldn't reprogram it.

We don't know what else to test in order to detect where the problem is. =
We
suppose that, as the only way to run again is reset the 3.3V, there must =
be
any peripheral that is not being working properly, but we don't know how =
to
find it and why this is happening.

Some clue is much appreciated.

Regards,

Moises.
