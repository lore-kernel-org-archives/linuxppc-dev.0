Return-Path: <orutsch@sympatec.com>
Received: from sympatec.com (mail.sympatec.net [217.5.250.35])
	(using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E9E8DDF67
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 16:26:22 +1000 (EST)
Received: from [172.20.3.151] (account rutsch [172.20.3.151] verified)
	by sympatec.com (CommuniGate Pro SMTP 5.1.4)
	with ESMTPSA id 1970004 for linuxppc-embedded@ozlabs.org;
	Mon, 27 Aug 2007 08:29:36 +0200
Message-ID: <46D26E3F.8040309@sympatec.com>
Date: Mon, 27 Aug 2007 08:25:03 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: STK5200 pci_enable_device problem
References: <20070826211021.BD3E724047@gemini.denx.de>
In-Reply-To: <20070826211021.BD3E724047@gemini.denx.de>
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

Hi,

[...]

 >> It's not so easy to compile the PLX drivers on the 4.1 ELDK because of
 >> missing headers in the ppc architecture. I managed to build the drivers
 >> for the 2.6.19 kernel and I was able to work with the card except the
 >> DMA routines (still working on this issue).
 >
 > WHy don't you use the arch/powerpc configuration, then? Note that the
 > STK5200 has never been supported in a  2.6  kernel  with  a  arch/ppc
 > configuration.
 >

Because I found at least a lite5200 configuration in the 4.1 ELDK 
(2.6.19.2 kernel) in the ARCH/ppc architecure. With ARCH/powerpc I only 
had a few configurations for other modules and I wasn't able to build a 
running kernel for the TQM5200 (maybe my fault).
Is there support for the TQM5200 and the STK5200 with ARCH/powerpc in 
newer kernels? I'm still using the 3.1.1 ELDK for the TQM5200 as it have 
everything I need and I don't need to use the PLX card in this board 
(although it would have been nice if I got it working...).

Bye,

-- 
Dipl. Ing. Oliver Rutsch
