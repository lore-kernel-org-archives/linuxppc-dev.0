Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 4CC16679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 17:44:07 +1000 (EST)
Message-ID: <42884F42.7090706@ru.mvista.com>
Date: Mon, 16 May 2005 11:44:02 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Allen Curtis <acurtis@onz.com>
References: <000601c557de$99627550$6601a8c0@D35HH141>	<757b7fc162262dae582e1d85b6f36e62@freescale.com>
	<541a45636bdf88d9eb3c08febd63d5c5@onz.com>
In-Reply-To: <541a45636bdf88d9eb3c08febd63d5c5@onz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to the
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Allen,
Some details about 8272 PCI below...
Allen Curtis wrote:

> Is the patch necessary? In the March archive it appears that people 
> were using the standard 8260 PCI support. What is the issue? Perhaps I 
> could provide a patch to m8260_pci.c (as you suggested)
>
The point is that stuff existent in the current tree for the 82xx has 
limited functionality.  Take a look at 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017948.html. 
Current source _does not_ contain any IRQ handlers & demux (which the 
patch adds), so the device will remain malfunction. Also the patch has 
some 8272 & PQ2FADS - specific bits.

>>> Where can I find the kernel tree with this integrated?
>>
>>
>> One doesn't exist.
>>
> Is there an embedded 2.5/2.6 tree somewhere? (I know about the 
> bkbits.net/ppc/linux-2.5 tree
>
There is no special `embedded` tree - use one from kernel.org or git 
repo if you need development version (http://www.kernel.org/git/).

-- 
Sincerely, 
Vitaly
