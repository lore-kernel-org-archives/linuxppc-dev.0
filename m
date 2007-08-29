Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id 68333DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 23:18:50 +1000 (EST)
Date: Wed, 29 Aug 2007 08:22:43 -0400
From: Marcelo Tosatti <marcelo@kvack.org>
To: Jochen Friedrich <jochen@scram.de>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page
	instantiation
Message-ID: <20070829122243.GA21150@dmt>
References: <46D40510.3060805@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46D40510.3060805@scram.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Please apply. 

On Tue, Aug 28, 2007 at 01:20:48PM +0200, Jochen Friedrich wrote:
> Instantiation of 8MB pages on the TLB cache for the kernel static
> mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
> This ensures r3 gets saved and restored.
> 
> This has been posted to linuxppc-embedded by Marcelo Tosatti
> <marcelo@kvack.org>, but only an incomplete version of the patch
> has been applied in c51e078f82096a7d35ac8ec2416272e843a0e1c4.
> This patch adds the rest of the fix.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/ppc/kernel/head_8xx.S |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> This can be pulled from git://git.bocc.de/dbox2.git ppc-fixes
