Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-3.online-age.net (ext-cn0ut-3.online-age.net
	[63.210.253.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1C425DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 00:21:28 +1000 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-3.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8TELOwh015865
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 10:21:24 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8TELNdL032539
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 10:21:23 -0400
Date: Mon, 29 Sep 2008 15:24:58 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 1/2] Drop redundant machine type print in show_cpuinfo
Message-Id: <20080929152458.d10aa365.martyn.welch@gefanuc.com>
In-Reply-To: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
References: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Sep 2008 16:53:34 -0500
Becky Bruce <becky.bruce@freescale.com> wrote:
> For many of the embedded boards, "model" and "Machine" are printing
> the same thing; remove the redundant code and allow the generic
> show_cpuinfo to print the model information.
> 

No prob.

> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

Acked-by: Martyn Welch <martyn.welch@gefanuc.com>

> ---
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    1 -
>  arch/powerpc/platforms/85xx/sbc8560.c             |    1 -
>  arch/powerpc/platforms/86xx/gef_sbc610.c          |    8 --------
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    8 --------
>  arch/powerpc/platforms/86xx/sbc8641d.c            |    8 --------
>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
>  6 files changed, 0 insertions(+), 27 deletions(-)
> 

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
