Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F2B5DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:44:20 +1100 (EST)
Subject: Re: Please pull from 'for-2.6.28' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1224547898.7654.210.camel@pasglop>
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<1224547898.7654.210.camel@pasglop>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 14:44:13 +1100
Message-Id: <1224560653.7654.224.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  - Finally, the Kconfig change shouldn't have been in your tree at all,
> or at least not without my or paulus ack and prior argeement that it
> should be merged that way. No big deal with this obviously correct
> patch but where do we put the limit ?

Same with the CONFIG_RELOCATABLE build fix. I'll pick both from
patchwork into my bundle for linus and they shouldn't go through
your tree unless prior approval.

Cheers,
Ben.
