Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55DFADDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 18:45:43 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3G8jWBk020221
	for <linuxppc-embedded@ozlabs.org>; Mon, 16 Apr 2007 09:45:32 +0100
Message-ID: <462337AB.5000507@computing.dundee.ac.uk>
Date: Mon, 16 Apr 2007 09:45:31 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Patchset to establish sanity in Xilinx Virtex support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> The Virtex support in Linus' tree is a mess.  When I ported the common
> devices over to using the platform bus I tried the use the ppc_sys
> infrastructure.  ppc_sys is intended for SoCs that have a fixed set of
> devices.  It is the *wrong* approach for FPGA support, and I made a
> royal mess of things.  This patch set fixes that problem and makes
> a number of other changes that make supporting Virtex boards easier.
>
> I do know that changes to arch/ppc are frowned upon at the moment.  However,
> 4xx support in arch/powerpc is not merged yet, and Virtex support needs
> additional work beyond that.  I suspect that arch/ppc support for the
> 4xx parts is going to need to stay alive for the next 2-3 kernel releases
> anyway while arch/powerpc support stablizes.  Getting these patches in
> will make it easier to support the Virtex ports while I hack on getting
> arch/powerpc stuff figured out.
>   
I have applied your patches to a 2.6.20.4 kernel, along with your 
SystemACE driver. I am fully up and running on a simple ML405-based 
system setup with a Uartlite and a SystemACE. (I made the Kconfig 
changes suggested by Dale Farnsworth to my copy). So, thank you very 
much. I appreciate the neatness of your patches, the fact that I now 
have early boot text support on my uartlite port and the fact that 
(somehow) you've shaved a good couple of seconds of my boot time against 
the Xilinx SystemACE driver. Thanks!

In your reply to Mohamed Sadegh Sadri you mentioned that you will be 
publishing your GIT tree with TEMAC support.  Two very quick questions: 
where do I find this, and does it support auto-negotiation properly?  I 
am having serious problems with auto-negotiation and the various 
flavours of driver out there.  It seems like the best long term plan 
would be to use the PHYLIB support to handle the PHY side of things but 
I have only just started looking into this.

Thanks again,
-- Peter



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
