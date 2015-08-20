Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18A6C1A0103
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 04:32:08 +1000 (AEST)
Date: Thu, 20 Aug 2015 20:31:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150820183158.GB3161@worktop.event.rightround.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440072876-8321-4-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 20, 2015 at 08:14:31PM +0800, Kevin Hao wrote:
> These are used to define a static_key_{true,false} array.

Yes but why...

there might have been some clue in the patches you didn't send me, but
since you didn't send them, I'm left wondering.
