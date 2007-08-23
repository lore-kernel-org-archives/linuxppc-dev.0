Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC366DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 06:23:07 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7NKN2qB022429
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 13:23:02 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l7NKN15k019049
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 15:23:01 -0500 (CDT)
Subject: Re: [PATCH 0/5] Remove unnecessary loops_per_jiffy initialization code
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <1185560634.8055.170.camel@ld0161-tx32>
References: <1185560634.8055.170.camel@ld0161-tx32>
Content-Type: text/plain
Message-Id: <1187900581.28951.17.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 23 Aug 2007 15:23:01 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-27 at 13:23, Jon Loeliger wrote:
> This patch series removes lingering jiffies initialization
> code from several platforms.  Note that the first patch in
> this series for the 86xx has been rebased to current top of
> Paul's repository and replaces an earlier version.
> 
> 
>  arch/powerpc/platforms/52xx/lite5200.c         |   13 ++-----------
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c      |   13 -------------
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c      |   13 -------------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c      |   11 -----------
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |   14 ++------------
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c   |   14 --------------
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c   |   14 --------------
>  arch/powerpc/platforms/embedded6xx/holly.c     |   12 ------------
>  arch/powerpc/platforms/embedded6xx/prpmc2800.c |    7 -------
>  9 files changed, 4 insertions(+), 107 deletions(-)

Kumar,

Any reason why patches 1/5 and 2/5, for 86xx and 85xx respectively,
did not get applied and ushered upstream with the others?

Thanks,
jdl
