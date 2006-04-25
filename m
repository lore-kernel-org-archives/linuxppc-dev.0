Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2192467A5D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 05:27:16 +1000 (EST)
Date: Tue, 25 Apr 2006 12:27:14 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425192714.GD1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<20060425184857.GB1132@gate.ebshome.net>
	<F2D4EB11-5E74-4A8E-9F73-B5BFEB2B950C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F2D4EB11-5E74-4A8E-9F73-B5BFEB2B950C@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 02:14:28PM -0500, Andy Fleming wrote:
> I think there's some confusion here (at least, I'm confused), so let  
> me see if I have this right:
> 
> 1) Kumar is advocating the eventual removal of support for booting  
> the 85xx CDS and 85xx ADS boards without a flat-device tree
> 
> 2) Eugene and Dan say this will break systems that are already deployed
> 
> 3) Kumar says that the 85xx CDS and ADS systems are reference  
> platforms, and therefore not meant for deployment.
> 
> 4) Eugene implies that removal of 85xx CDS and ADS support from arch/ 
> ppc should be accompanied by some sort of compatibility options for  
> booting arch/powerpc Linux from an old u-boot
> 
> Do I have this right?

Yes :)

-- 
Eugene
