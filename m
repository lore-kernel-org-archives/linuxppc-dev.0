Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 358F02C0165
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 23:10:32 +1000 (EST)
Subject: Re: [PATCH] powerpc/epapr: export epapr_hypercall_start
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120810222121.GA9408@tyr.buserror.net>
Date: Sat, 11 Aug 2012 15:10:23 +0200
Message-Id: <D6818778-6A5C-40D9-BE1A-3885ED4B4AA5@suse.de>
References: <20120810222121.GA9408@tyr.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.08.2012, at 00:21, Scott Wood wrote:

> This fixes breakage introduced by the following commit:
> 
>  commit 6d2d82627f4f1e96a33664ace494fa363e0495cb
>  Author: Liu Yu-B13201 <Yu.Liu@freescale.com>
>  Date:   Tue Jul 3 05:48:56 2012 +0000
> 
>    PPC: Don't use hardcoded opcode for ePAPR hcall invocation
> 
> when a driver that uses ePAPR hypercalls is built as a module.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Sending to Alex even though this isn't KVM-specific since the commit it
> fixes is still only in his tree (and linux-next).

Thanks, applied to kvm-ppc-next.


Alex
