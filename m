Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 8226A68051
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 17:57:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 10 Aug 2005 09:58:05 +0200
Message-ID: <8E342283C2100540AAC5D10309705477749DCF@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: fs_enet on MPC885ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
> Sent: Wednesday, August 10, 2005 9:26 AM

> > Schaefer-Hutter, Peter wrote:
> > Reason i'm asking is that the current cpm_uart driver doesn't work
> > with the SCC3 ethernet driver included in the MPC885 board support
> > (as soon as ethernet is initialized, console output stops).
>=20
> This is very interesting since AFAIR SCC3 eth will not work with SMC2
on=20
> my board, but maybe something is changed.=20

Well, SMC2 ist disabled in the config, the DIP switches are set for
10BaseT... But i must confess that i've not looked very deep into that.

> Anyway, oue fs_enet is pretty close to upstream so it would be nice if

> you will use (and test :)) it.

Sure! I'm your guinea pig :)

Best regards,

  Peter
