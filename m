Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-6.online-age.net (ext-cn0ut-6.online-age.net
	[63.210.253.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B5539DEF60
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 20:59:48 +1000 (EST)
Received: from int-cn0ut-6.online-age.net (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by ext-cn0ut-6.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7MAxisD032224
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 06:59:45 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by int-cn0ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7MAxiIE023618
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 06:59:44 -0400
Date: Fri, 22 Aug 2008 11:58:54 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc: Default configuration for GE Fanuc SBC610
Message-Id: <20080822115854.bf59c87d.martyn.welch@gefanuc.com>
In-Reply-To: <23669159-8A9C-4264-BFB0-A903CFDD7D8E@kernel.crashing.org>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104625.11984.2953.stgit@ubuntu8041.localdomain>
	<23669159-8A9C-4264-BFB0-A903CFDD7D8E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008 05:57:51 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 22, 2008, at 5:46 AM, Martyn Welch wrote:
> 
> > Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> > (PowerPC
> > MPC8641D).
> >
> > This is the default config file for GE Fanuc's SBC610, a 6U single  
> > board
> > computer, based on Freescale's MPC8641D.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> > ---
> >
> > arch/powerpc/configs/gef_sbc610_defconfig | 1654 ++++++++++++++++++++ 
> > +++++++++
> > 1 files changed, 1654 insertions(+), 0 deletions(-)
> 
> Do you mind putting this under configs/86xx/gef_sbc610_defconfig (I  
> know it 86xx/ doesn't exist but we are getting enough boards there to  
> make it useful).
> 

Will do.

> - k


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
