Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-7.online-age.net (ext-nj2ut-7.online-age.net
	[64.14.54.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8DA08DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 00:52:13 +1100 (EST)
Received: from int-nj2ut-7.online-age.net (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by ext-nj2ut-7.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAIDq8nE028616
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 08:52:08 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by int-nj2ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAIDq1KW025665
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 08:52:08 -0500
Date: Tue, 18 Nov 2008 13:53:42 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Use generic PHY driver for Marvell 88E1111 PHY
	on GE Fanuc SBC610
Message-Id: <20081118135342.3605930c.martyn.welch@gefanuc.com>
In-Reply-To: <7110514B-F0F1-4650-A3CC-E09178CBC262@kernel.crashing.org>
References: <20081118102023.7047.94495.stgit@ubuntu8041.localdomain>
	<20081118105451.7835.78476.stgit@ubuntu8041.localdomain>
	<7110514B-F0F1-4650-A3CC-E09178CBC262@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Nov 2008 07:39:21 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> On Nov 18, 2008, at 4:55 AM, Martyn Welch wrote:
> 
> > The Marvell PHY driver is currently being used for the 88E1111 on the
> > SBC610. This driver is causing the link to run in 10/Half mode, the  
> > generic
> > PHY driver is correctly configuring the PHY as 1000/Full.
> >
> > Edit default config to use generic PHY driver.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> > ---
> >
> > Agh! My mistake - forgot to add "Signed-off", sorry.
> >
> > arch/powerpc/configs/86xx/gef_sbc610_defconfig |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> hmm.. why not fix the issue with the 88e1111 driver.
> 

Two reasons really:

1) We don't use any of the non-generic features of the PHY.
2) Networking is really _not_ my forte.

As a result, it's not itching ;-)

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
