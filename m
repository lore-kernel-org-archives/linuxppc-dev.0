Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 83035B70BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 02:31:58 +1100 (EST)
Subject: Re: [PATCH 5/5,
 v3] powerpc/fsl: Document rapidio node binding-information
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917D6@CORPEXCH1.na.ads.idt.com>
Date: Wed, 16 Nov 2011 09:31:27 -0600
Message-Id: <51A1AB39-34DC-4189-9ADA-2D41F8252EE3@kernel.crashing.org>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-5-git-send-email-Gang.Liu@freescale.com>
 <0CE8B6BE3C4AD74AB97D9D29BD24E552024917D6@CORPEXCH1.na.ads.idt.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com,
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


On Nov 16, 2011, at 7:49 AM, Bounine, Alexandre wrote:

>> -----Original Message-----
>> From: Liu Gang [mailto:Gang.Liu@freescale.com]
>> Sent: Saturday, November 12, 2011 7:03 AM
>> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
>> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
>> r58472@freescale.com; B11780@freescale.com; r61911@freescale.com; Liu
>> Gang; Li Yang; Jin Qing; Kumar Gala
>> Subject: [PATCH 5/5,v3] powerpc/fsl: Document rapidio node binding-
>> information
>> 
>> This document is created for powerpc rapidio and rmu nodes in dts
> file.
>> These nodes can support two rapidio ports and message units. In
>> addition,
>> It explicates the properties and gives examples about rapidio and rmu
>> nodes.
>> 
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Jin Qing <b24347@freescale.com>
>> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> .../devicetree/bindings/powerpc/fsl/srio-rmu.txt   |  163
>> ++++++++++++++++++++
>> .../devicetree/bindings/powerpc/fsl/srio.txt       |  103
> ++++++++++++
>> 2 files changed, 266 insertions(+), 0 deletions(-)
>> create mode 100644
> Documentation/devicetree/bindings/powerpc/fsl/srio-
>> rmu.txt
>> create mode 100644
>> Documentation/devicetree/bindings/powerpc/fsl/srio.txt
>> 
> 
> Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>

applied to 'next'

- k
