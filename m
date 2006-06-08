Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D1DD467C03
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 06:17:35 +1000 (EST)
Subject: Re: [PATCH 9/10] Add Vitesse 8244 PHY for MPC8641 HPCN platform.
From: Jon Loeliger <jdl@freescale.com>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44887BD3.7000009@garzik.org>
References: <1149720298.23938.207.camel@cashmere.sps.mot.com>
	<44887BD3.7000009@garzik.org>
Content-Type: text/plain
Message-Id: <1149797603.23938.251.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 15:13:28 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 14:34, Jeff Garzik wrote:
> Jon Loeliger wrote:
> > Signed-off-by: Kriston Carson <KristonCarson@freescale.com>
> > Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> ACK, but patch does not apply to netdev-2.6.git#upstream.
> 
> 	Jeff

Thanks, Jeff.

Are you willing to take the netdev parts as-is, then?
Or would you like me to reformat the netdev parts to
apply against the netdev-2.6.git#upstream branch?
The patch is currently for the Paul Mackerras powerpc.git
tree as it stands now.  Should we apply it through that
path now as you have ACK'ed it?

Thanks,
jdl
