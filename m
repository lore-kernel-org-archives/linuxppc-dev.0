Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A35D21A01DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 10:53:32 +1100 (AEDT)
Date: Wed, 2 Dec 2015 15:53:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhao Qiang <qiang.zhao@freescale.com>
Cc: <lauraa@codeaurora.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <olof@lixom.net>,
 <catalin.marinas@arm.com>, <scottwood@freescale.com>, <X.xie@freescale.com>
Subject: Re: [PATCH v13 1/6] genalloc:support memory-allocation with
 bytes-alignment to genalloc
Message-Id: <20151202155330.0c3656f67e9f46a677bde8eb@linux-foundation.org>
In-Reply-To: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 30 Nov 2015 10:48:52 +0800 Zhao Qiang <qiang.zhao@freescale.com> wrote:

> Bytes alignment is required to manage some special RAM,
> so add gen_pool_first_fit_align to genalloc,
> meanwhile add gen_pool_alloc_algo to pass algo in case user
> layer using more than one algo, and pass data to
> gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)

Patches 1 & 2 look OK to me.  Please include them in whichever (powerpc)
tree is used for patches 3-6.
