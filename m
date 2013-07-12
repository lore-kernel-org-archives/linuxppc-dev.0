Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CDE452C033F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 09:05:49 +1000 (EST)
Message-ID: <1373670339.19894.214.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 13 Jul 2013 09:05:39 +1000
In-Reply-To: <1373662399.8183.283@snotra>
References: <1373546721.19894.90.camel@pasglop> <1373553002.8183.245@snotra>
 <20130712022512.GB32154@pek-khao-d1.corp.ad.wrs.com>
 <1373662399.8183.283@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-12 at 15:53 -0500, Scott Wood wrote:
> 
> It's not redundant at all to warn when an FPU is absent.  It tells you  
> that you're being slowed down by running hard-FP code instead of  
> soft-FP code.

Right, just warn always.

Ben.
