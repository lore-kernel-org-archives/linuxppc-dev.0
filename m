Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C7462BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 20:55:19 +1100 (EST)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: robin.gilks@tait.co.nz
In-Reply-To: <41B67FCF.6040100@tait.co.nz>
References: <41B67FCF.6040100@tait.co.nz>
Content-Type: text/plain
Message-Id: <1102498710.414.98.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 10:38:30 +0100
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Exception handling on mpc8xx cores
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2004-12-08 at 05:15, Robin Gilks wrote:
> Greetings
> 
> Any Freescale lurkers out there?
> 
> The mpc866 manual implies that if the internal core times out an 
> external Transfer Acknowledge bus signal (by exerting the internally 
> generated Transfer Error Acknowledge signal) an exception is generated.
> 
> I've tried extending the external TA signal well beyond 2040 clock 
> cycles the maximum timeout allows and I see the busses start up again 
> (indicationg that they are no longer waiting) but I don't see anything 
> on TEA and I don't get an exception thrown.
> 
> Any clues? Manual error?, silicon error?, my brain error?

Did you enable the bus monitor in the SYPCR register?

Jaap-Jan

> 
> Cheers
-- 
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl
