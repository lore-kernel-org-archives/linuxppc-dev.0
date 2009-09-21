Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B66C5B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 00:24:58 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: "Cote, Sylvain" <Sylvain.Cote@verint.com>
Subject: Re: PPC_4xx synopsy USB driver
Date: Mon, 21 Sep 2009 16:24:52 +0200
References: <579B119545DAEF4689C8FBEEFEC5793F01FA07D04F37@ATLMBX.verint.corp.verintsystems.com>
	<200909210713.29238.sr@denx.de>
	<579B119545DAEF4689C8FBEEFEC5793F01FA07D05186@ATLMBX.verint.corp.verintsystems.com>
In-Reply-To: <579B119545DAEF4689C8FBEEFEC5793F01FA07D05186@ATLMBX.verint.corp.verintsystems.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909211624.52060.sr@denx.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 21 September 2009 15:44:30 Cote, Sylvain wrote:
> > Looks good so far. I suspect that the only thing missing for your 405EX
> > custom
> > board is the following line in the arch/powerpc/sysdev/Makefile:
> >
> > obj-$(CONFIG_KILAUEA)           += amcc-usbotg.o
> 
> I have created a new platform (platform using 405ex).  I have missed this
>  one for my new platform.  Do you know if there is a compilation switch
>  that could be more generic (like CONFIG_40x) for the usbotg?

Yes, it would probably make sense to just use 

obj-$(CONFIG_USB_DWC_OTG) += amcc-usbotg.o

here. I'll change this soon.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
