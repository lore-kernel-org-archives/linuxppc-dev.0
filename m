Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by ozlabs.org (Postfix) with ESMTP id C66F267B4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 00:33:33 +1000 (EST)
Received: from fau-vscan-1.rrze.uni-erlangen.de ([131.188.3.181]
	[131.188.3.181]) by faurelaysmart-1.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Thu, 18 May 2006 16:32:51 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
	by fau-vscan-1.rrze.uni-erlangen.de (fau-vscan-1.rrze.uni-erlangen.de
	[131.188.2.91]) (amavisd-new)
	with ESMTP id 09847-09 for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 16:32:51 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Thu, 18 May 2006 16:32:51 +0200
Message-Id: <446C8593.1070603@cs.fau.de>
Date: Thu, 18 May 2006 16:32:51 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8xx USB SOF microcode patch
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


Hello,

I am using linux 2.6.15 and try to get the MPC875 USB controller 
working. I just checked if the microcode patch in 
arch/ppc/8xx_io/micropatch.c for CONFIG_USB_SOF_UCODE_PATCH set 
corresponds with the newest microcode patch for mpc8xx, downloadable 
from freescale: They differ slighly, is it an older (working) version or 
where is it from ?

ciao
josef
