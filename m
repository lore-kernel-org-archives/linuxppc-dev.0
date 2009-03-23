Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34433DDEF5
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 16:45:30 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2N5jQeZ028120
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 22:45:26 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n2N5jO8J007613
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 00:45:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: suspend-to-mem on the mpc8349e-mitx-gp?
Date: Mon, 23 Mar 2009 13:45:23 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
In-Reply-To: <49C3AB35.4080700@freescale.com>
References: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
	<49C3AB35.4080700@freescale.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421=20
> Sent: Friday, March 20, 2009 10:42 PM
> To: Li Yang-R58472
> Cc: Soohyung Cho; linuxppc-dev@ozlabs.org
> Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
>=20
> Li Yang-R58472 wrote:
> >> However, the code should treat "mem" as "standby" on chips=20
> that don't=20
> >> support deep sleep.  What does the device tree
> >=20
> > Well, shouldn't the valid() callback reject unsupported=20
> states instead=20
> > of covering up?
>=20
> I don't think so, in this case.  The user is not asking for=20
> "sleep" or deep sleep"; they are asking for a power state=20
> that meets the definition of "standby" (which sleep does) or=20
> which meets the definition of "mem"=20
> (which both sleep and deep sleep do).  When the user asks for=20
> "mem", we provide the lowest power mode that qualifies.

In my understanding, "mem" which is suspend-to-ram means all CPU states =
and registers are kept in memory and the CPU is completely off during =
suspension.  I don't think the sleep mode of 8349 qualifies, does it?

- Leo
