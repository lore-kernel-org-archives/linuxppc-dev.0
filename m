Return-Path: <B34182@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47981B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 23:54:02 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the compile errors when building
 with 64bit
From: Liu Gang <Gang.Liu@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B946A444-73EC-4A70-AA7E-31FAF31FFF13@kernel.crashing.org>
References: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
 <6BFCD6C7-7675-4A99-9C4C-4E86FA5642A4@kernel.crashing.org>
 <1330957222.23420.136.camel@10.ap.freescale.net>
 <B946A444-73EC-4A70-AA7E-31FAF31FFF13@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 7 Mar 2012 20:52:21 +0800
Message-ID: <1331124741.23420.140.camel@10.ap.freescale.net>
MIME-Version: 1.0
Cc: r58472@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, r61911@freescale.com, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Kumar,

On Tue, 2012-03-06 at 11:46 -0600, Kumar Gala wrote:
> How about a struct instead:
> 
> struct rmu_dmsg {
> 	u16	dummy;
> 	u16	tid;
> 	u16	sid;
> 	u16	info;
> };
> 
> 	struct rmu_dmsg *dmsg = fsl_dbell->dbell_ring.virt + (in_be32(&fsl_dbell->dbell_regs->dqdpar) & 0xfff);
> 
> Than you can git rid of the DBELL_* macros.

Yes, this can really git rid of the DBELL_* macros and some other code.
I'll update the patch based on your comments.
Thanks a lot.

Liu Gang
