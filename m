Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 723F8DDF06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 01:41:28 +1100 (EST)
Message-ID: <474D7C2E.7080702@freescale.com>
Date: Wed, 28 Nov 2007 08:33:18 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: John Williams <jwilliams@itee.uq.edu.au>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>	<4749425C.5060207@dlasys.net>	<20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>	<474CAE70.3030005@itee.uq.edu.au>	<20071128002835.068BE16A005D@mail198-sin.bigfish.com>
	<474CBBDE.9010007@itee.uq.edu.au>
In-Reply-To: <474CBBDE.9010007@itee.uq.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Michal Simek <simekm2@fel.cvut.cz>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Williams wrote:

> Well, copying multiple configuration files into the kernel is not ideal. 

Well, some advances in the DTC are being developed to help
mitigate the proliferation of DTS files there.  It's still
slow going, but we're working on it...

>   Surely a little perl or python script would do the trick?  DTS syntax 
> is pretty clean, 

Are you looking at the same DTS I am? :-)


> Another thing I suggested to Michal recently, perhaps we need 
> kernel/lib/libof to store common OF / DT handling code.  Much better 
> than duplicating it accross microblaze and PPC, and maybe other arch's 
> would also see the light..

Not sure exactly what you mean here, but there are libfdt
efforts in the DTC source repo already.  That code is being
used in U-Boot.  There is also already a shared library  of
OF/DT handling code in the kernel that is being used by
both PowerPC and SPARC today.  I believe there are plans to
head it towards the same libfdt as well.

>  That would also add a claim for the DTC to 
> go in scripts/

Which, for the record, I'm not really convinced is the
right thing to do yet.

> John

Thanks,
jdl
