Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F000DDE21
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 01:48:38 +1000 (EST)
Subject: Re: Patches added to for_paulus (queue'd for 2.6.23)
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <790E72AD-637C-4C13-8266-CDD285573DF6@kernel.crashing.org>
References: <790E72AD-637C-4C13-8266-CDD285573DF6@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1183650508.26273.35.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 05 Jul 2007 10:48:28 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-03 at 04:17, Kumar Gala wrote:
> I'm still working through the back log of patches related to ppc32/ 
> fsl.  If there are patches people want to make sure get into 2.6.23  
> let me know.

> Jon Loeliger (1):
>        [POWERPC] Replace use of GET_64BIT(prop, i) with of_read_number().

Kumar,

Please also pick this one up too:

    From: 	Jon Loeliger <jdl@freescale.com>
    To: 	linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org>
    Cc: 	pci-ids@ucw.cz
    Subject: 	[PATCH v2 7/9] Add Freescale PCI VENDOR ID.
    Date: 	Mon, 04 Jun 2007 17:30:

Thanks,
jdl
