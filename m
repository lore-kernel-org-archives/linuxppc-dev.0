Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50B08DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:12:34 +1100 (EST)
Message-ID: <479A27AF.5080701@freescale.com>
Date: Fri, 25 Jan 2008 12:17:19 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc, legacy_serial: add support for
	"soc" compatible matching
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
	<20080125171355.GA9879@localhost.localdomain>
In-Reply-To: <20080125171355.GA9879@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Freescale soc register space: "fsl,soc"
> generic soc device: "soc" (or maybe "linux,soc" better?)
> 
> I know, Scott Wood is pushing "xxxx-immr" thing forward... but
> I don't like that name because SOC isn't only device with the
> Internal Memory Mapped Registers. 

If you look in the manual for xxxx, you'll find something called 
"Internal Memory Mapped Registers".  Thus, the name xxxx-immr.

>(Think of QE placed outside of "soc"/"immr" node).

When is the QE ever placed outside the soc/immr/ccsr node?
The QE registers are part of the IMMR/CCSR.

-Scott
