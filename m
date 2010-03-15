Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D019FB7D88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Mar 2010 10:46:43 +1100 (EST)
Date: Mon, 15 Mar 2010 16:46:25 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] sysdev: the cpu probe/release attributes should be
	sysdev_class_attributes
Message-ID: <20100315234625.GA12575@kroah.com>
References: <20100316103332.ade0b5d9.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100316103332.ade0b5d9.sfr@canb.auug.org.au>
Cc: Andi Kleen <andi@firstfloor.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 16, 2010 at 10:33:32AM +1100, Stephen Rothwell wrote:
> This fixes these warnings:
> 
> drivers/base/cpu.c:264: warning: initialization from incompatible pointer type
> drivers/base/cpu.c:265: warning: initialization from incompatible pointer type
> 
> Cc: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/base/cpu.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> Hi Greg,
> 
> Could you pleas send this on to Linuse as this is now a bug in mainline.

Will do, thanks so much for fixing this up correctly.

greg k-h
