Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 333A32C008C
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 04:26:40 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130118144047.616d315258f4d23834363b33@freescale.com>
Date: Tue, 12 Feb 2013 11:26:36 -0600
Message-Id: <3D277CC6-2C2C-46E7-B0F8-FAECED8BC868@kernel.crashing.org>
References: <1358500573-19477-1-git-send-email-po.liu@freescale.com>
 <20130118144047.616d315258f4d23834363b33@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Po Liu <po.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2013, at 2:40 PM, Kim Phillips wrote:

> On Fri, 18 Jan 2013 17:16:13 +0800
> Po Liu <po.liu@freescale.com> wrote:
> 
>> This facilitates getting the physical address of the SEC node.
>> 
>> Signed-off-by: Liu po <po.liu@freescale.com>
>> ---
> Reviewed-by: Kim Phillips <kim.phillips@freescale.com>
> 
> Kim

This was missing a trailing ';', so wondering if it was ever tested?

I fixed when I applied.

applied.

- k
