Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0F204DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 22:02:16 +1000 (EST)
Date: Tue, 17 Jul 2007 14:02:37 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: hvc_iseries not working
Message-ID: <20070717120237.GA24912@aepfle.de>
References: <20070713170540.GA1987@aepfle.de>
	<1184600356.22547.121.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1184600356.22547.121.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 16, Will Schmidt wrote:

> On Fri, 2007-07-13 at 19:05 +0200, Olaf Hering wrote:
> > 2.6.21 arch/powerpc/configs/iseries_defconfig works on an i825 with v5r4
> > 2.6.22 arch/powerpc/configs/iseries_defconfig does not. But it works on
> > a i820 with v5r3.
> > 2.6.22 boots ok with CONFIG_VIOCONS
> 
> When it works, do you have more than one processor assigned to the
> partition?   

The partition does not change, only the kernel (And iseries_defconfig) changes.
The partition has a single cpu assigned, 0.8 %
