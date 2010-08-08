Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 444B4B6F06
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 07:52:57 +1000 (EST)
Message-ID: <4C5F2731.4090605@emcraft.com>
Date: Mon, 09 Aug 2010 01:52:49 +0400
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

On 05.08.2010 12:02, Kumar Gala wrote:
> However that is not true, so we have to search through the inbound
> window settings on 83xx to find which one matches the IMMR address to
> determine its PCI address.
>    

Thanks,  your patch really does help on MPC8308 board I use.

Regards, Ilya.
