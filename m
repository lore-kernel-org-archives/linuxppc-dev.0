Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 012EBB70FF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 02:55:13 +1100 (EST)
Subject: Re: [PATCH 4/5,
 v3] powerpc/8xxx: Update device tree bus probe for new RapidIO node
 binding
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917D5@CORPEXCH1.na.ads.idt.com>
Date: Wed, 16 Nov 2011 09:33:04 -0600
Message-Id: <677A59A9-DEE6-4959-92EA-865D8D589A76@kernel.crashing.org>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
 <0CE8B6BE3C4AD74AB97D9D29BD24E552024917D5@CORPEXCH1.na.ads.idt.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Cc: r58472@freescale.com, Kai Jiang <Kai.Jiang@freescale.com>,
 linux-kernel@vger.kernel.org, r61911@freescale.com,
 Liu Gang <Gang.Liu@freescale.com>, B11780@freescale.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2011, at 7:48 AM, Bounine, Alexandre wrote:

>> -----Original Message-----
>> From: Liu Gang [mailto:Gang.Liu@freescale.com]
>> Sent: Saturday, November 12, 2011 7:03 AM
>> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
>> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
>> r58472@freescale.com; B11780@freescale.com; r61911@freescale.com; Kai
>> Jiang; Kumar Gala
>> Subject: [PATCH 4/5,v3] powerpc/8xxx: Update device tree bus probe for
>> new RapidIO node binding
>> 
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>> 
>> Update of_platform_bus_probe() RapidIO node to be compitable with
>> new RapidIO dts compatible property.
>> 
>> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
>> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>> 3 files changed, 3 insertions(+), 3 deletions(-)
>> 
> 
> Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>


applied to 'next'

- k
