Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 361C4DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 12:54:01 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6B2ruJc001132
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:53:56 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6B2rrIw027685
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 21:53:54 -0500 (CDT)
Subject: Re: [patch 5/6] Update the 83xx/85xx/86xx boards device tree
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <FFEC5443-109B-45B7-80CA-0252F9365B55@kernel.crashing.org>
References: <1184082783.20129.193.camel@localhost.localdomain>
	<FFEC5443-109B-45B7-80CA-0252F9365B55@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184122420.22066.35.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jul 2007 10:53:40 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 04:28, Segher Boessenkool wrote:
> > Indentify pci, pcie host by compatible property
> > "fsl,mpc83xx-pci","83xx"
> > "fsl,mpc85xx-pci","85xx"
> > "fsl,mpc86xx-pci","86xx"
> > and
> > "fsl, mpc85xx-pciex","85xx"
> > "fsl, mpc86xx-pciex","86xx"
> 
> This can't ever work -- 
It works!
> if you see "compatible" = "85xx",
> what is it?
That's why I remove the original compatible "85xx".

>   PCI or PCIe?  Or something else perhaps, maybe
> a CPU or an I2C controller or who-knows-what?
I just think the compatible field
"fsl,mpc83xx-pci","83xx"
has some redundant information.
Kumar don't want to break anything using the old  
information.  
We can remove it in the future:-).
Roy
