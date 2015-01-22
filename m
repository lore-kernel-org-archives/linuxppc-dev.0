Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84BE31A0DDB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 12:12:25 +1100 (AEDT)
Message-ID: <1421889142.4598.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Replace cpumask_weight(cpu_possible_mask) with
 num_possible_cpus()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 22 Jan 2015 12:12:22 +1100
In-Reply-To: <1421878874-30422-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421878874-30422-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 16:21 -0600, Emil Medve wrote:
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Why?

Because:

   #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)


But please say so in future. I'll fix it up this time.

cheers
