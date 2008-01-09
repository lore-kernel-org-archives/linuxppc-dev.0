Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F307CDE3C6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:30:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Help with device tree binding for SMC serial
Date: Wed, 9 Jan 2008 13:18:49 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

We're trying to get a SMC serial port on a8280 to work.
I cannot find any ecxamples on the binding, so we've tried to make one.

is this anywhere close to workable?

serial@11a80 {
	device_type =3D "serial";
	compatible =3D "fsl,mpc8280-smc-uart",
				 "fsl,cpm2-smc-uart";
	reg =3D <11a80 10 87fc 2>;
	interrupts =3D <4 8>;
	interrupt-parent =3D <&PIC>;
	fsl,cpm-brg =3D <7>;
	fsl,cpm-command =3D <01000000>;
};
