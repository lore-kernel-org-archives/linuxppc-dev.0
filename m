Return-Path: <john.traill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74E2ADDF09
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 19:44:19 +1000 (EST)
Message-ID: <48CF7FEB.2050506@freescale.com>
Date: Tue, 16 Sep 2008 10:44:11 +0100
From: John Traill <john.traill@freescale.com>
MIME-Version: 1.0
To: rpoornar@yahoo.com
Subject: Re: dts file for ep8548A board
References: <462940.11077.qm@web57006.mail.re3.yahoo.com>
In-Reply-To: <462940.11077.qm@web57006.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't know if this helps but ..

The EP boards I've used have an old version of u-boot which don't support passing the device tree address so I've had to build a cuImage.

Cheers.

poornima r wrote:
> Hi all,
> 
> I am working on ep8548A embedded planet board.
> I am using mpc8548cds dtb file (mpc8548cds.dts file in 
> arch/powerpc/boot/dts directory of the kernel source) as my device tree 
> file.
> I am tracing the kernel initilization path through BDI.
> The BDI tracing is hanging in early_init_devtree ( in machine_init 
> function) if the r3 register (physical pointer to device tree block) is 
> not set to dtb file loaded location in RAM.
> Once I set the r3 register manually in BDI (rm r3 <dtb file location>) 
> the kernel is passing machine_init function (passing early_init_devtree( 
> ) ).
> I tried  to statically set r3 register in head_fsl_booke.S  file by 
> using ori instruction but I was not able to set the r3 value to dtb file 
> RAM location.
> Are any changes necessary in mps8548cds.dts for ep8548A board?
> How do we and where should we set the r3 register value in 
> head_fsl_booke.S file for device tree initilization?
> 
> Thanks,
> Poornima
>  
>  
> 
>  
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 
John Traill
Systems Engineer
Network and Computing Systems Group

Freescale Semiconductor UK LTD
Colvilles Road
East Kilbride
Glasgow G75 0TG, Scotland

Tel: +44 (0) 1355 355494
Fax: +44 (0) 1355 261790

E-mail: john.traill@freescale.com

Registration Number: SC262720
VAT Number: GB831329053

[ ] General Business Use
[ ] Freescale Internal Use Only
[ ] Freescale Confidential Proprietary
