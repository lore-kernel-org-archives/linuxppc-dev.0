Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 659D0DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 05:18:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8260ADS and linux-2.6
Date: Thu, 3 Jan 2008 12:18:25 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03D1682A@ismail.innsys.innovsys.com>
In-Reply-To: <477D2255.3040803@freescale.com>
References: <a3b98ac10801022105w240b0f96race4d3aa84e51f27@mail.gmail.com>
	<477D2255.3040803@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"suja Baburaj" <sujababuraj@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Scott Wood
> Sent: Thursday, January 03, 2008 11:59 AM
> To: suja Baburaj
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8260ADS and linux-2.6
>=20
> suja Baburaj wrote:
> > I have an MPC8260ADS board with (eldk)linux-2.4.25 working=20
> fine on it.
> > Now i want to try linux-2.6.X on the board.
>=20
> There's no support for that specific board in mainstream 2.6=20
> yet, but it=20
> should be fairly simple to get it working using the=20
> mpc8272ads support=20
> as an example.

There is support, but it is in arch/ppc not arch/powerpc
(PQ2FADS support works for this board in arch/ppc)
