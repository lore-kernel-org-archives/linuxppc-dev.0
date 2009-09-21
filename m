Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA33CB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Sep 2009 15:13:39 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: PPC_4xx synopsy USB driver
Date: Mon, 21 Sep 2009 07:13:29 +0200
References: <579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37@ATLMBX.verint.corp.verintsystems.com>
In-Reply-To: <579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37@ATLMBX.verint.corp.verintsystems.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909210713.29238.sr@denx.de>
Cc: "Cote, Sylvain" <Sylvain.Cote@verint.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sylvain,

On Friday 18 September 2009 17:50:24 Cote, Sylvain wrote:
> USB gadget support --> y
>             Maximum VBUS power usage = 500
>             Synopsys DWC OTG controller
>             Synopsys DWC OTG internal DMA mode --> y
>             USB gadget --> M
>             gadget zero --> M
>             Ethernet Gadget --> M
>             RNDIS support --> y
> 
> Any help will be appreciated

Looks good so far. I suspect that the only thing missing for your 405EX custom 
board is the following line in the arch/powerpc/sysdev/Makefile:

obj-$(CONFIG_KILAUEA)           += amcc-usbotg.o

to enable the device-tree to platform-device driver wrapper for the USB-OTG 
resources.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
