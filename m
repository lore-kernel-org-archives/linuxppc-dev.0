Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71E03B7311
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 02:33:47 +1100 (EST)
Subject: Re: [PATCH 2/5,
 v3] fsl-rio: Add two ports and rapidio message units support
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917CC@CORPEXCH1.na.ads.idt.com>
Date: Wed, 16 Nov 2011 09:33:15 -0600
Message-Id: <D97116A8-B63C-4A38-B637-EDCD3129A078@kernel.crashing.org>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-2-git-send-email-Gang.Liu@freescale.com>
 <0CE8B6BE3C4AD74AB97D9D29BD24E552024917CC@CORPEXCH1.na.ads.idt.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com, r61911@freescale.com,
 linux-kernel@vger.kernel.org, Liu Gang <Gang.Liu@freescale.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2011, at 7:39 AM, Bounine, Alexandre wrote:

>> -----Original Message-----
>> From: linuxppc-dev-bounces+alexandre.bounine=idt.com@lists.ozlabs.org
>> [mailto:linuxppc-dev-
>> bounces+alexandre.bounine=idt.com@lists.ozlabs.org] On Behalf Of Liu
>> Gang
>> Sent: Saturday, November 12, 2011 7:02 AM
>> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
>> Cc: Jin Qing; r58472@freescale.com; r61911@freescale.com; linux-
>> kernel@vger.kernel.org; Liu Gang; akpm@linux-foundation.org;
>> B11780@freescale.com
>> Subject: [PATCH 2/5, v3] fsl-rio: Add two ports and rapidio message
>> units support
>> 
>> Usually, freescale rapidio endpoint can support one or two 1x or 4X
>> LP-Serial link interfaces, and rapidio message transactions can be
>> implemented by two message units. This adds the support of two
>> rapidio ports and initializes message unit 0 and message unit 1. And
>> these ports and message units can work simultaneously.
>> 
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Jin Qing <b24347@freescale.com>
>> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/sysdev/fsl_rio.c |  391 +++++++++++++++++++++-----------
>> arch/powerpc/sysdev/fsl_rio.h |   75 ++++++-
>> arch/powerpc/sysdev/fsl_rmu.c |  502
> ++++++++++++++++++---------------
>> --------
>> 3 files changed, 545 insertions(+), 423 deletions(-)
>> 
> 
> Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
> 

applied to 'next'

- k
