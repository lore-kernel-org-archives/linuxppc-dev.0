Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C09DDDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 10:37:29 +1100 (EST)
Date: Mon, 19 Nov 2007 17:36:52 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	jgarzik@pobox.com
Subject: Re: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Message-Id: <20071119173652.55e385b2.kim.phillips@freescale.com>
In-Reply-To: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
References: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 Nov 2007 12:15:30 -0600
Kim Phillips <kim.phillips@freescale.com> wrote:

> Hello all,
> 
> the following patches fix RGMII timing for rev. 2.1 of the mpc8360,
> according to erratum #2 (erratum text included below).  Basically the
> most intrusive part is the addition of two new RGMII Internal Delay
> modes; one for TX delay only, and the other for RX delay only (i.e, not
> both at the same time).
> 
> Please review, and since this affects both netdev and powerpc trees,
> one maintainer should ack them for the other to push upstream (i.e,
> Kumar acks them, and Leo picks them up to go through netdev or the
> other way around; either way is fine with me).  I'm hoping they're
> trivial enough to go in 2.6.24.
> 
Kumar, Leo, 

re-ping due to (a) it's been 2 weeks and (b) Anton Vorontsov has since
issued his Tested-by.

Might I suggest Kumar ack the powerpc patches, and Leo/Jeff apply 5/5
to go through netdev?

Kim
