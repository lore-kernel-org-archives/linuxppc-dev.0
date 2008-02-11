Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7CB8DDF30
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 08:56:51 +1100 (EST)
Message-Id: <27AAC964-D9EE-435A-84FD-8A45FF27D448@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Jiang <djiang@mvista.com>
In-Reply-To: <20080211203445.GB5331@blade.az.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] powerpc: create mpc85xx pci err platform device for
	EDAC
Date: Mon, 11 Feb 2008 15:56:08 -0600
References: <20080211203445.GB5331@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 11, 2008, at 2:34 PM, Dave Jiang wrote:

> Creating a platform device for the PCI error registers in order for  
> the
> mpc85xx EDAC driver to pick up proper resources. This is to prevent  
> the
> EDAC driver from monopolizing the of_device and thus preventing  
> future PCI
> code from using the PCI of_device(s).
>
> Signed-off-by: Dave Jiang <djiang@mvista.com>

I'd rather we didn't add new platform devices, but do this via  
of_platform in the driver itself.

Also, we need to 'rename' the compatible field for some of these  
devices.

- k
