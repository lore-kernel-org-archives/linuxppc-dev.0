Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id 09A112BDA6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 21:42:13 +1000 (EST)
In-Reply-To: <20040923200802.56313C108D@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Message-ID: <OF29350850.2043EBA0-ON00256F19.00329A63-00256F19.0040556E@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Fri, 24 Sep 2004 11:42:41 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: MPC5200 with PCF8563 RTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

wd@denx.de wrote on 23.09.2004 20:07:57:

>=20
> > I am however having a more difficult time getting the linux kernel=20
> > (linuxppc=5F2=5F4=5Fdevel from Denx) to work with PCF8563.  I get error=
s=20
from=20
> > rtc=5Frd( ), but I
> > can't understand why.  I have compared the i2c clock signals between=20
>=20
> It works fine on the PM520...
>=20

Thanks for your hints.  I tried configuring the kernel for the pm520 board
(make PM520=5Fconfig) and then the RTC stuff works on my board.  Obviously I
had something misconfigured that resulted in the strange behaviour of i2c.

>=20
>=20
> > eth0: status: link up, 100 Mbps Half Duplex.
>                                   ^^^^^^^^^^^^
> Is this correct?

No, it is actually incorrect and this is something that I need to fix.
My board (NS4) has a DP83847 PHY on the FEC.  I modified fec.c to avoid
kernel panic, but I do not have the PHY handling 100% correct yet.
Ethernet communications are working though, at least when connected to=20
a Cisco Catalyst 2950 with autonegotiation it establishes 100 Mbps Full=20
Duplex.
When connected to an old HP 10Mbps hub linux reports as above, 100 MBps=20
Half Duplex,
but the communications do work despite wrong reported speed.

Any suggestions for reference code for DP83847 with MPC5200 ?

Many thanks,
J=F3n Benediktsson
Marel hf.
