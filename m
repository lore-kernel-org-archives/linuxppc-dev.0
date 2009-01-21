Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D4B98DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:44:02 +1100 (EST)
Date: Tue, 20 Jan 2009 19:46:59 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: more printing warning fixes for the l64 to
	ll64 conversion
Message-ID: <20090121014659.GA7000@lixom.net>
References: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
Cc: Nick Spence <nick.spence@freescale.com>, linuxppc-dev@ozlabs.org,
	Egor Martovetsky <egor@pasemi.com>, Paul Mackerras <paulus@samba.org>,
	Doug Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 11:16:51AM +1100, Stephen Rothwell wrote:
> These are all powerpc specific drivers.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

pasemi_nand.c pieces:

Acked-by: Olof Johansson <olof@lixom.net>
