Return-Path: <mchaffin@microsatsystems.com>
Received: from [63.150.173.66] (itnmail.itnes.com [63.150.173.66])
	by ozlabs.org (Postfix) with ESMTP id ECB2367CE2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 06:28:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problem connecting a Ti TUSB2077a hub to Cypress SL811 host
Date: Tue, 7 Nov 2006 12:29:09 -0700
Message-ID: <B9D56A48380DF34CA0922A7C2450D4797B2E8D@itnmail1.itnes.com>
From: "Chaffin, Michael" <mchaffin@microsatsystems.com>
To: "gear" <gear@hyper.cx>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: gear [mailto:gear@XXX.XXX]=20
> Sent: Tuesday, November 07, 2006 10:43 AM
> To: Chaffin, Michael
> Subject: Re: Problem connecting a Ti TUSB2077a hub to Cypress=20
> SL811 host
>=20
> error -110 is time out.
>=20
> Is interrupt correctly treatable?

Which interrupt line? I am looking at the Ti Documentation (SLLS414A -
March 2000 Revised December 2004 ) and I do not see an 'interrupt' line?


Now the hub chip is /not/ powered via the host controller,
	Sl811 Pin 7 & 8 ( USB Data +/-) to TUSB pin 3 & 4=20
	TUSB pin 9 & 46 (Vcc and -Vcc) to 3.3 Volts

Should the second set of pins (9 & 46) be attached\controlled at the
power output of the host controller?
=20
> Tomoshige Hirohata
> hirohata@XXX.XX
=20
