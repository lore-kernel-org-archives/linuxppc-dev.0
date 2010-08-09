Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 609C9B70AB
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 22:58:46 +1000 (EST)
Message-ID: <4C5FFB7F.2090709@emcraft.com>
Date: Mon, 09 Aug 2010 16:58:39 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl-pci: Fix MSI support on 83xx platforms
References: <1280995347-6550-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1280995347-6550-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1251; format=flowed
Cc: linuxppc-dev@ozlabs.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Hi Kumar,

05.08.2010 12:02, Kumar Gala wrote:
> The following commit broke 83xx because it assumed the 83xx platforms
> exposed the "IMMR" address in BAR0 like the 85xx/86xx/QoriQ devices do:
>
> commit 3da34aae03d498ee62f75aa7467de93cce3030fd
> Author: Kumar Gala<galak@kernel.crashing.org>
> Date:   Tue May 12 15:51:56 2009 -0500
>
>      powerpc/fsl: Support unique MSI addresses per PCIe Root Complex
>
> However that is not true, so we have to search through the inbound
> window settings on 83xx to find which one matches the IMMR address to
> determine its PCI address.

As I've already told you my testing on the MPC8308RDB board was 
successful. As for 85xx boards, Wolfgang told me that DENX doesn't have 
any 85xx boards that support MSI at the moment, so I can't do complete 
testing. I'm sorry. I've tested that TQM8560 boards is able to boot and 
PCI is working as expected though (with your patch applied). I fear I 
can't do anything else here.

Thanks.

Regards, Ilya.
