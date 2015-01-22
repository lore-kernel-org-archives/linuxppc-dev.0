Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7D1F1A0D16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 13:03:18 +1100 (AEDT)
Message-ID: <54C0565C.7020601@Freescale.com>
Date: Wed, 21 Jan 2015 19:46:04 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Replace cpumask_weight(cpu_possible_mask) with
 num_possible_cpus()
References: <1421878874-30422-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421889142.4598.2.camel@ellerman.id.au>
In-Reply-To: <1421889142.4598.2.camel@ellerman.id.au>
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,


On 01/21/2015 07:12 PM, Michael Ellerman wrote:
> On Wed, 2015-01-21 at 16:21 -0600, Emil Medve wrote:
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> 
> Why?
> 
> Because:
> 
>    #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
> 
> 
> But please say so in future. I'll fix it up this time.

Thank you


Cheers,
