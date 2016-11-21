Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMc7k5jhqzDt3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:08:34 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:05:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: PPC: sparse: prototypes for functions called
 from assembler
Message-ID: <20161121050509.GI26748@fergus.ozlabs.ibm.com>
References: <1476059480-18145-1-git-send-email-dja@axtens.net>
 <1476059480-18145-2-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476059480-18145-2-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 11:31:20AM +1100, Daniel Axtens wrote:
> A bunch of KVM functions are only called from assembler.
> Give them prototypes in asm-prototypes.h
> This reduces sparse warnings.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Thanks, applied to kvm-ppc-next.

Paul.
