Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 48AB7B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:44:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 922B5DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:44:02 +1000 (EST)
Message-Id: <8BA2A0E3-4C40-4775-9062-9E31DAB83463@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090724214230.GB2718@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/2] powerpc/83xx: Add eSDHC support for MPC837xE-RDB/WLAN
	boards
Date: Thu, 6 Aug 2009 21:43:54 -0500
References: <20090724214230.GB2718@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 24, 2009, at 4:42 PM, Anton Vorontsov wrote:

> Actually, the support is already there, but it requires newer U-Boots
> (to fill-in clock-frequency, and setup pin multiplexing).
>
> Though, it appears that on RDB boards USBB pins aren't multiplexed
> between USB and eSDHC (unlike MDS boards, where USB and eSDHC share
> pctl and pwrfault pins).
>
> So, for RDB boards we can safely setup pinmux and manually fill-in
> clock-frequency, thus making eSDHC work even with older u-boots.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_rdb.dts     |    2 +-
> arch/powerpc/boot/dts/mpc8378_rdb.dts     |    2 +-
> arch/powerpc/boot/dts/mpc8379_rdb.dts     |    2 +-
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |   23 ++++++++++++++++++++ 
> +++
> arch/powerpc/platforms/83xx/mpc83xx.h     |    4 ++++
> 5 files changed, 30 insertions(+), 3 deletions(-)

applied to next.

- k
