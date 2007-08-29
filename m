Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32FE9DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 16:03:52 +1000 (EST)
Received: from [172.20.3.151] (account rutsch [172.20.3.151] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1981129 for linuxppc-embedded@ozlabs.org;
	Wed, 29 Aug 2007 08:04:05 +0200
Message-ID: <46D50C0B.80402@sympatec.com>
Date: Wed, 29 Aug 2007 08:02:51 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
References: <20070827191419.9A9CE24044@gemini.denx.de>
	<7B9A8FF57DBB524190E98CABF6E56F070B9283@itri.bte.mam.gov.tr>
In-Reply-To: <7B9A8FF57DBB524190E98CABF6E56F070B9283@itri.bte.mam.gov.tr>
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

Hi Mustafa,

> Hi,
> 
> i build Linux-2.6.22-gbcfc8d37 kernel lastest kernel from denx git for 
> the board (STK5200 with TQM5200-AB).
> ELDK 4.1 version is used.
> 
> make mrproper
> export ARCH=powerpc
> make tqm5200_defconfig
> make uImage
> 
> It hangs on after  following line
>   Uncompressing Kernel Image ... OK
> 

I encountered exactly the same problem. Using U-Boot 1.2 with Kernel 
Linux-2.6.22-gef92f1d7 and a TQM5200S-BD module on the STK52000. I tried 
to modify some kernel settings but it always stopped booting at the 
"Uncompressing Kernel Image ... OK" line.

Bye,
-- 
Dipl. Ing. Oliver Rutsch
