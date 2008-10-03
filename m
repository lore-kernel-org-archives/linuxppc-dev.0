Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA5C1DE0DE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 06:28:10 +1000 (EST)
Message-ID: <48E67FCE.8010201@freescale.com>
Date: Fri, 03 Oct 2008 15:25:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Ditto <mditto@consentry.com>
Subject: Re: unit name for /soc in device tree
References: <48E67CDD.8080002@consentry.com>
In-Reply-To: <48E67CDD.8080002@consentry.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Ditto wrote:
> I'm starting a scratch port of Linux 2.6 to an MPC8272 board that currently
> runs 2.4 (MontaVista).
> 
> Documentation/powerpc/booting-without-of.txt says:
>     The name of an soc
>     node should start with "soc", and the remainder of the name should
>     represent the part number for the soc.  For example, the MPC8540's
>     soc node would be called "soc8540".

Gah, what's that still doing in there?  Ignore it.
It's a bad idea, for exactly this reason.

-Scott
