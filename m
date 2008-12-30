Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id C6C8ADDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 09:27:33 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1621668ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 14:27:32 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <495AA054.7090903@genesi-usa.com>
Date: Tue, 30 Dec 2008 16:27:32 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Update 8641hpcn dts file to match latest u-boot
References: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> The newest revision of uboot reworks the memory map for this
> board to look more like the 85xx boards.  Also, some regions
> which were far larger than the actual hardware have been scaled
> back to match the board, and the imaginary second flash bank has
> been removed. Rapidio and PCI are mutually exclusive in the hardware,
> and they now are occupying the same space in the address map.
> The Rapidio node is commented out of the .dts since PCI is the
> common use case.

Hi Becky,

What would be the "newest revision of U-Boot" that implements this 
memory map? We're entering into moving-target territory again here where 
we have no real idea which kernels are required or work or are even 
supported on which versions of the firmware.. and of course this device
tree committed to mainline means that the next set of kernel.org won't
have the right data to boot what could be a perfectly workable kernel
on previous U-Boot versions.

Isn't there any documentation on this apart from git changesets hidden 
behind obscure many-digit hashes?

--
Matt Sealey <matt@genesi-usa.com>
