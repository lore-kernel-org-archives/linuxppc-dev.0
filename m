Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA8F91A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:47:21 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/cell: Remove the Cell QPACE code.
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
Cc: ben@codiert.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5656E334.1060506@redhat.com>
Date: Thu, 26 Nov 2015 11:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/11/15 01:59, Rashmica Gupta wrote:
> All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
>  arch/powerpc/boot/Makefile                |   2 -
>  arch/powerpc/configs/ppc64_defconfig      |   1 -
>  arch/powerpc/platforms/cell/Kconfig       |   5 -
>  arch/powerpc/platforms/cell/Makefile      |   3 -
>  arch/powerpc/platforms/cell/qpace_setup.c | 148 ------------------------------
>  5 files changed, 159 deletions(-)
>  delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c

There one more reference to qpace in the file
 Documentation/devicetree/bindings/serial/8250.txt
... you might want to remove that, too.

 Thomas
