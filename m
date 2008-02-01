Return-Path: <SRS0=TP32=SW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7D067DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 21:19:23 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] pci: Fix bus resource assignment on 32 bits with 64b
	resources
Date: Fri, 1 Feb 2008 11:18:56 +0100
References: <20071210063216.89DBBDDE1E@ozlabs.org>
In-Reply-To: <20071210063216.89DBBDDE1E@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802011118.57610.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 10 December 2007, Benjamin Herrenschmidt wrote:
> The current pci_assign_unassigned_resources() code doesn't work properly
> on 32 bits platforms with 64 bits resources. The main reason is the use
> of unsigned long in various places instead of resource_size_t.
>
> This fixes it, along with some tricks to avoid casting to 64 bits on
> platforms that don't need it in every printk around.
>
> This is a pre-requisite for making powerpc use the generic code instead of
> its own half-useful implementation.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Checking Linus's latest git repository, it seems this patch (and the 2nd from 
this series) hasn't been applied till now. This is just a reminder, that it 
gets in in this merge-window.

Thanks.

Best regards,
Stefan
