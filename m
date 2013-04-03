Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD8D12C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 03:46:20 +1100 (EST)
Subject: Re: [PATCH] sgy-cts1000: Remove __dev* attributes
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1A7562E2-E3F4-499C-AB2E-788D08234B02@gmail.com>
Date: Wed, 3 Apr 2013 11:46:11 -0500
Message-Id: <33D9B386-8D85-4EBA-8DA7-5A9DC5225E54@kernel.crashing.org>
References: <1A7562E2-E3F4-499C-AB2E-788D08234B02@gmail.com>
To: Ben Collins <benmcollins13@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 6:19 PM, Ben Collins wrote:

> Somehow the driver snuck in with these still in it.
> 
> Signed-off-by: Ben Collins <ben.c@servergy.com>
> ---
> arch/powerpc/platforms/85xx/sgy_cts1000.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

applied to next

- k
