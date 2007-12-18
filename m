Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88B1FDDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 21:41:15 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: Arnon Kaufman <arnon.kaufman@gmail.com>
Date: Tue, 18 Dec 2007 11:41:02 +0100
References: <47652712.60006@gmail.com> <20071216154458.GZ3851@pengutronix.de>
	<47656048.7060809@gmail.com>
In-Reply-To: <47656048.7060809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712181141.03706.jbe@pengutronix.de>
Subject: Re: [MPC5200] problem running FEC and ATA
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 16 December 2007 18:28, Arnon Kaufman wrote:
> Robert Schwebel wrote:
>> On Sun, Dec 16, 2007 at 03:24:34PM +0200, Arnon Kaufman wrote:
>>> does any one succeed running a functional FEC and ATA (pata) running
>>> together?
>>
>> Yes, we do, on the phyCORE-MPC5200B-tiny; you can check our patches here:
>> http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-ti=
ny/
>
> thanks, my kernels are already patched and still observing that kind of
> behavior. I'm using Domen's new FEC code and ATA from 2.6.24-rc2.

I tried our kernel (see link above) with an external harddisk and NFS. I=20
copied various files from the harddisk to NFS root and vice versa. No data=
=20
corruption.

Can you check our patch stack on your hardware?

Juergen
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
