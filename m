Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZlm17lDzF2Ch
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:44 +1000 (AEST)
In-Reply-To: <20180507142019.32669-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [v2,
 1/4] powerpc: wii_defconfig: Disable Ethernet driver support code
Message-Id: <40hZll2TTNz9s1p@ozlabs.org>
Date: Fri, 11 May 2018 00:06:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 14:20:16 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
> a different menu. Disable CONFIG_ETHERNET to save some space in support
> code for Ethernet drivers.
> 
> Note that this patch doesn't disable any Ethernet drivers, because they
> are not enabled by default.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a84813f5bf2948c2a2947b0d684562

cheers
