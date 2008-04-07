Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66982DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 07:37:40 +1000 (EST)
Message-Id: <73BD1263-F09B-4E08-AA77-BEBD67D91C58@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 4xx defconfig reorg
Date: Mon, 7 Apr 2008 16:36:48 -0500
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2008, at 8:06 AM, Josh Boyer wrote:
> Hi All,
>
> Unless someone screams loudly and has reasons why this shouldn't go  
> in,
> the following commit should hit the 4xx next branch in the next day or
> so.
>
> josh

If this is acceptable to people, I'll make similar defconfig movements  
for the Freescale parts.

- k

> commit eaf997b847be3c351eb9d0107e0562035dc58095
> Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Date:   Sun Apr 6 08:01:21 2008 -0500
>
>   [POWERPC] 4xx: Reorganize 4xx defconfigs
>
>   Board specific defconfigs are useful, however with the ability to do
>   multi-board defconfigs they aren't needed in the top level configs  
> directory
>
>   Move the 4xx board specific defconfigs to individual directories  
> under
>   arch/powerpc/configs.
>
>   Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> arch/powerpc/configs/{ => 40x}/ep405_defconfig     |    0
> arch/powerpc/configs/{ => 40x}/kilauea_defconfig   |    0
> arch/powerpc/configs/{ => 40x}/makalu_defconfig    |    0
> arch/powerpc/configs/{ => 40x}/walnut_defconfig    |    0
> arch/powerpc/configs/{ => 44x}/bamboo_defconfig    |    0
> .../configs/{ => 44x}/canyonlands_defconfig        |    0
> arch/powerpc/configs/{ => 44x}/ebony_defconfig     |    0
> arch/powerpc/configs/{ => 44x}/katmai_defconfig    |    0
> arch/powerpc/configs/{ => 44x}/rainier_defconfig   |    0
> arch/powerpc/configs/{ => 44x}/sequoia_defconfig   |    0
> arch/powerpc/configs/{ => 44x}/taishan_defconfig   |    0
> arch/powerpc/configs/{ => 44x}/warp_defconfig      |    0
> 12 files changed, 0 insertions(+), 0 deletions(-)
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
