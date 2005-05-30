Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 07477679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 01:04:17 +1000 (EST)
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DcloN-0004Wo-00
	for linuxppc-embedded@ozlabs.org; Mon, 30 May 2005 17:04:15 +0200
Received: from [84.154.92.251] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DcloN-0005io-00
	for linuxppc-embedded@ozlabs.org; Mon, 30 May 2005 17:04:15 +0200
Message-ID: <429B2B54.1060504@anagramm.de>
Date: Mon, 30 May 2005 17:03:48 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Complete ccsr map for mpc8540 available?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, There!

I want to access the local bus controller (LBC) registers
of the mpc8540 from within a module.
Therefore I want to use similar structures as for the 8560's cpm2_immr
or the 8xx. However, I was not able to find a complete ccsr map for the 
mpc8540 in the 2.6.11.x kernels. (immap_85xx.h, 8xx_immr.h, ...)

Can someone point me to get the memc_brx / orx and friends for mpc8540?
(the complete CCSR map.) Or some code to recycle?
Or do I need to patch more into immap_85xx.h on my own? I just want to
avoid to do duplicate work.

Or is it better to extend the fsl_ocp or the platform device structures?

Thanks,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
