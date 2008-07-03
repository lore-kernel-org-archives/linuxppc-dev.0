Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C3DCDE0D7
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:29:54 +1000 (EST)
Message-ID: <486D1A58.8010403@freescale.com>
Date: Thu, 03 Jul 2008 13:28:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: New fsl device bindings file
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
In-Reply-To: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I'm sure you'll hate for doing this, but I've asked Kim to create a new 
> Documentation/powerpc/fsl-device-tree-bindings.txt as part of his SEC 
> patch.
> 
> I'm going to move all the Freescale SoC related bindings into this new 
> file.  One of the aspects of the new file is we will NOT having an 
> ordinal heading index.

How about splitting up like this:

Documentation/powerpc/device-tree/fsl/cpm.txt
Documentation/powerpc/device-tree/fsl/cpm/uart.txt
Documentation/powerpc/device-tree/fsl/tsec.txt
Documentation/powerpc/device-tree/interrupts.txt
Documentation/powerpc/device-tree/dtb.txt

etc?

-Scott
