Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E67BDDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:38:08 +1000 (EST)
Message-ID: <49EF8E3A.4060304@freescale.com>
Date: Wed, 22 Apr 2009 16:38:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
In-Reply-To: <282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I disagree.  If you update your kernel you should update your device 
> tree (thus we have .dts in the kernel tree and not somewhere else).

No.  The device tree is a means to pass information from the firmware to 
the kernel.  It is part of the firmware.  That the repository of trees 
is in the Linux kernel for any boards which are not including the tree 
inside a bootwrapper is a historical accident.

Updating the dtb with the kernel just shifts the risk of incompatibility 
to interactions between the firmware and the dtb.  The same backwards 
compatibility considerations when making kernel changes that depend on 
firmware changes should be made when making kernel changes that depend 
on dts changes.

-Scott
