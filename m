Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 94207140116
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 12:33:34 +1000 (EST)
Message-ID: <1398998002.2925.15.camel@pasglop>
Subject: Re: [4/5] IBM Akebono: Add the Akebono platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Fri, 02 May 2014 12:33:22 +1000
In-Reply-To: <10214508.Vq3Ynjy2Co@mexican>
References: <1394077948-8395-5-git-send-email-alistair@popple.id.au>
 <1398936447.4121.12.camel@x220> <10214508.Vq3Ynjy2Co@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Paul Bolle <pebolle@tiscali.nl>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-02 at 10:35 +1000, Alistair Popple wrote:

> > The plan to add MMC_SDHCI_OF_476GTR seems to have been abandoned (see
> > the discussion of https://lkml.org/lkml/2014/2/21/24 ). So this select
> > is not needed. Should I submit a trivial patch to drop this select?
> 
> Thanks for pointing this out, I should have removed the select for 
> MMC_SDHCI_OF_476GTR as suggested. I can submit a patch to drop the select or 
> send an updated version of the original patch. Which is easiest for you Ben?

I don't rebase next so it has to be a followup patch.

Cheers,
Ben.

> > > +	select ATA
> > > +	select SATA_AHCI_PLATFORM
> > > +	help
> > > +	  This option enables support for the IBM Akebono (476gtr) evaluation
> > > board +
> > > +
> > > 
> > >  config ICON
> > >  
> > >  	bool "Icon"
> > >  	depends on 44x
> > 
> > Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
