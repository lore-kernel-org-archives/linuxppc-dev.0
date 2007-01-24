Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail4.alcatel.fr (smail4.alcatel.fr [62.23.212.167])
	by ozlabs.org (Postfix) with ESMTP id B30EBDDF43
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 00:00:43 +1100 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail4.alcatel.fr (ALCANET/NETFR) with ESMTP id l0OD0Y4O002317
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Jan 2007 14:00:34 +0100
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id OAA23396
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 14:00:33 +0100 (MET)
Received: from frilld0063506 (frilld0063506 [172.25.48.83])
	by mail (8.8.8p2+Sun/) with SMTP id OAA23390
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 14:00:33 +0100 (MET)
Date: Wed, 24 Jan 2007 13:56:22 +0100
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [MPC8349ITX] USB Init with PPC arch
Message-Id: <20070124135622.edd0206a.benjamin.zores@alcatel-lucent.fr>
In-Reply-To: <E856EB0C-D2B9-41CA-8F75-3B1A0F60AC7B@kernel.crashing.org>
References: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
	<3B008FD0-DF55-492B-A60A-EF0F9F8F75AB@kernel.crashing.org>
	<20070123091802.95605193.benjamin.zores@alcatel-lucent.fr>
	<E856EB0C-D2B9-41CA-8F75-3B1A0F60AC7B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 23 Jan 2007 10:18:34 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> Take a look at this patch from Randy Vinson that adds support to arch/ 
> ppc for USB.
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021773.html

Thanks for the hint.
I've seen the part that was missing in my own patch and now the MPH is well detected (though the DR one still hangs the card but it's useless to me atm).

Ben
