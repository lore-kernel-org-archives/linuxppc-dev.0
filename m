Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431A21A09C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:14 +1100 (AEDT)
In-Reply-To: <1448941898-10123-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: thuth@redhat.com, arnd@arndb.de, ben@codiert.org
Subject: Re: [v2] powerpc/cell: Remove the Cell QPACE code
Message-Id: <20151215112714.20C4D140323@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-12 at 03:51:38 UTC, Rashmica Gupta wrote:
> All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/24ad1648edcc8b1c4a68c406

cheers
