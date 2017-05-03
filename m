Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHV2J1szDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:19:02 +1000 (AEST)
In-Reply-To: <20170501005331.20131-3-alastair@au1.ibm.com>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alastair D'Silva <alastair@d-silva.org>, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, frederic.barrat@fr.ibm.com
Subject: Re: [v4] cxl: mask slice error interrupts after first occurrence
Message-Id: <3wJCHT6y5Rz9rxm@ozlabs.org>
Date: Thu,  4 May 2017 08:19:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-01 at 00:53:31 UTC, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In some situations, a faulty AFU slice may create an interrupt storm of
> slice errors, rendering the machine unusable. Since these interrupts are
> informational only, present the interrupt once, then mask it off to
> prevent it from being retriggered until the AFU is reset.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a715626a8e904e7226915d1bc48853

cheers
