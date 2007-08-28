Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75621DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 05:49:32 +1000 (EST)
Message-ID: <46D47C46.5080901@am.sony.com>
Date: Tue, 28 Aug 2007 12:49:26 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: Re: [PATCH] PS3: fix the bug the major version part is not compared
References: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp>
In-Reply-To: <20070828211415.C2B5.MOKUNO@sm.sony.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Masakazu Mokuno wrote:
> Fix the bug that the major version part of the firmware 
> is not compared.
> 
> Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> CC: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/platforms/ps3/setup.c |    2 +-
>  include/asm-powerpc/ps3.h          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Paul,

Firmware 2.0.x will be out in the coming months, so it would
be nice if this could go in for 2.6.23.


Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
