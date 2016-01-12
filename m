Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97E4C1A1071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:53 +1100 (AEDT)
In-Reply-To: <1452230207-26253-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Remove misleading comment in pci.c
Message-Id: <20160112123253.2BD01140B99@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-01 at 05:16:47 UTC, Russell Currey wrote:
> PCI in powernv now supports quite a bit more than p5ioc2, so remove the
> outdated comment.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0eab5b29a55fd9f31fad28df5

cheers
