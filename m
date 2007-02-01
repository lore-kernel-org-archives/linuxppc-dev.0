Return-Path: <peter.ryser@xilinx.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1B3FCDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 01:59:21 +1100 (EST)
Received: from outbound2-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-blu-R.bigfish.com (Postfix) with ESMTP id 41C991A29643
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 14:59:18 +0000 (UTC)
Received: from mail80-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound2-blu.bigfish.com (Postfix) with ESMTP id 09E3330043
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 14:59:17 +0000 (UTC)
Received: from mail80-blu (localhost.localdomain [127.0.0.1])
	by mail80-blu-R.bigfish.com (Postfix) with ESMTP id 1EB5F18882A7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 14:59:17 +0000 (UTC)
Received: from newsgate.xilinx.com (gateway4.xilinx.com [149.199.60.204])
	by mail80-blu.bigfish.com (Postfix) with ESMTP id A00B1DA008B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 14:59:14 +0000 (UTC)
Received: from cliff.xilinx.com (cliff [149.199.38.103])
	by newsgate.xilinx.com (8.11.6p2/8.11.6) with ESMTP id l11ExDi13413
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Feb 2007 06:59:13 -0800 (PST)
Received: from xsj-exchfesmtp2.xlnx.xilinx.com (localhost [127.0.0.1])
	by cliff.xilinx.com (8.12.9/8.11.6) with ESMTP id l11ExCC2002457
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Feb 2007 06:59:13 -0800 (PST)
Message-ID: <45C1FFEE.9020500@xilinx.com>
Date: Thu, 01 Feb 2007 06:57:50 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Led astray? Xilinx ml410 + u-boot + Linux?
References: <89CE61D4-C939-4788-A0AE-30EF410E9628@anti-paladin.com>
In-Reply-To: <89CE61D4-C939-4788-A0AE-30EF410E9628@anti-paladin.com>
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

Joe,

please have a look at http://www.xilinx.com/ml410-p. The pages do 
contain information, documentation, and examples on how to use U-Boot 
and Linux 2.4 on the ML410.
There are Linux 2.6 solutions for the ML40x boards (ML403 and ML405) 
from MontaVista and Wind River. Since the ML40x boards are in key parts 
identical to the ML410 you can use those ports as a starting point for a 
port to the ML410.

- Peter


Joe wrote:
> I was told (by Xilinx reps!) that the Xilinx ML410 "supported" Linux.
>
> My goal is to have something "load" Linux and then execute it -- 
> preferably over NFS / Ethernet (for development purposes).
>
> As far as I can tell from searching the 'Net the ML403 is fairly well 
> supported but I have yet to see any level of confirmation that the 
> ML410 fully supports u-boot, Linux and Ethernet.
>
> When I download the u-boot file(s) from Xilinx they basically don't work:
>
>   0)  I get a u-boot command prompt via the serial port!! ;)
>   1)  The u-boot loadb command fails to accept any data via the kermit 
> protocol
>   2)  The u-boot 'dhcp' command fails to obtain an address -- either 
> by simply crashing or by sitting there indicating that it is re-trying 
> (in which case an Ethernet sniffer shows no activity from the Ethernet 
> ports).
>
> Linux 2.6.19 shows arc/ppc/configs/ml[403|300]_defconfig, but I see 
> *zero* indication that the 410 is supported.  Has anyone seen the 
> ML410 fully functional with Linux + a patch to enable the Ethernet ports?
> (I also note that on the mvi$ta site they list support for:  ML300 and 
> ML40x -- but NOT the ML410.)  My searches also seem to indicate that 
> the IP included for the 410 Ethernet MAC's is distinctly different 
> from the 403...
>
> My current project has a *very* short fuse -- I should have been 
> "running" (e.g. past init into a shell w/filesystem) two weeks ago.
>
> If someone could confirm that this platform *is* supported (and I'm 
> just missing this on my searches) I'd be quite grateful for some 
> pointers on where to re-direct my searches.
>
> OTOH, if someone could confirm that this platform is NOT currently 
> supported that would be just as useful -- decisions can be made and 
> actions taken.
>
> TIA.
>
> -- 
> Joe
>
>
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
