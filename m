Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 01514679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 05:45:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 19 May 2005 15:45:50 -0400
Message-ID: <0007F077BB3476449151699150E8FEA21A7B9E@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: tah reset?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

Yes, TAH0 in SDR0_MFR register is enabled.

EMAC is able to reset correctly, but TAH isn't at the same location [in =
emac_probe()]. PHY is connected to EMAC and TAH is behind EMAC. I do not =
understand how the RX clock from PHY will reach TAH? Any suggestions ?

Thanks,
Sanjay

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Thursday, May 19, 2005 2:23 PM
To: Sanjay Bajaj
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: tah reset?


On Thu, May 19, 2005 at 02:14:20PM -0400, Sanjay Bajaj wrote:
> While trying to reset the TAH on emac2 of PPC440GX, the Soft Reset=20
> (SR) bit never resets itself to 0. Does anybody know the reason for=20
> it?

Did you enable TAH0 in SDR0_MFR register?

Also, I don't remember for sure, but TAH may have the same problem as=20
EMAC, namely, it won't go out of reset if there is no RX clock from=20
PHY.

--=20
Eugene
