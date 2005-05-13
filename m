Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id BB72F67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 07:09:46 +1000 (EST)
In-Reply-To: <757b7fc162262dae582e1d85b6f36e62@freescale.com>
References: <000601c557de$99627550$6601a8c0@D35HH141>
	<757b7fc162262dae582e1d85b6f36e62@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <541a45636bdf88d9eb3c08febd63d5c5@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Fri, 13 May 2005 14:09:46 -0700
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Ppc Embedded <linuxppc-embedded@ozlabs.org>
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

Is the patch necessary? In the March archive it appears that people 
were using the standard 8260 PCI support. What is the issue? Perhaps I 
could provide a patch to m8260_pci.c (as you suggested)

>> Where can I find the kernel tree with this integrated?
>
> One doesn't exist.
>
Is there an embedded 2.5/2.6 tree somewhere? (I know about the 
bkbits.net/ppc/linux-2.5 tree

TIA
