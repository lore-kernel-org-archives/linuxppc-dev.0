Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5150E1A25EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 08:47:39 +1000 (AEST)
Date: Wed, 9 Sep 2015 08:47:35 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: tim.gardner@canonical.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Leonidas Da Silva Barbosa <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] powerpc: define empty enable_kernel_vsx() when
 CONFIG_VSX=n
Message-ID: <20150908224735.GA12791@fergus.ozlabs.ibm.com>
References: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441735991-29199-1-git-send-email-tim.gardner@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 08, 2015 at 12:13:11PM -0600, tim.gardner@canonical.com wrote:
> From: Tim Gardner <tim.gardner@canonical.com>
> 
> commit 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx()
> routine available") neglected to define an empty inline replacement for
> enable_kernel_vsx() when CONFIG_VSX=n.

If code that wants to call enable_kernel_vsx() is getting compiled in
when CONFIG_VSX=n, that's a worry.  Is this patch motivated by an
actual compile failure?  If so what was the failure?

Paul.
