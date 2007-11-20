Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75FF7DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 02:52:33 +1100 (EST)
Date: Tue, 20 Nov 2007 09:52:22 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for-2.6.24' branch
Message-Id: <20071120095222.bd737987.kim.phillips@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0711192355460.1265@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711192355460.1265@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2007 23:56:23 -0600 (CST)
Kumar Gala <galak@kernel.crashing.org> wrote:

> Kim Phillips (4):
>       [POWERPC] 83xx: mpc832x mds: Fix board PHY reset code
>       [POWERPC] 83xx: Fix 2nd UCC entry in mpc832x_mds.dts
>       [POWERPC] Document rgmii-rxid and rgmii-txid phy-connection-types
>       [POWERPC] 83xx: Handle mpc8360 rev. 2.1 RGMII timing erratum
>

Hi Kumar,

thanks for applying these, here's one you missed:

http://patchwork.ozlabs.org/linuxppc/patch?id=14651

Kim
