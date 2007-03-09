Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3C1DDDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 22:35:20 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l29BZ7aD062124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Fri, 9 Mar 2007 12:35:12 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HPdNL-0002K0-7l
	for linuxppc-embedded@ozlabs.org; Fri, 09 Mar 2007 12:35:07 +0100
Date: Fri, 9 Mar 2007 12:35:07 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070309113506.GB6726@server.idefix.lan>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello John,

* John Rigby <jrigby@freescale.com> [07-03-07 14:17]:
> On a stock lite5200b the only thing that shows up is a serial
> eeprom at address 0x50.

thx a lot, that tool helped me a lot.
I have written a very small c-program to access the I2C bus to read the
temperature of my MAX6633 and convert it to °C.

That worked fine, but after reading the value some time, the I2C bus
is dead. The kernel says:
i2c_adapter i2c-1: ioctl, cmd=0x705, arg=0x7feaf8ec
i2c_adapter i2c-1: ioctl, cmd=0x706, arg=0x40
i2c_adapter i2c-1: ioctl, cmd=0x720, arg=0x7feaf8f0
i2c_adapter i2c-1: master_xfer[0] W, addr=0x40, len=1
i2c_adapter i2c-1: master_xfer[1] R, addr=0x40, len=2
I2C: timeout

Is that maybe a bug in the I2C driver (i2c-mpc) or is my programm
faulty?
If it helps I can attach the programm.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
