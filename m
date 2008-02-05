Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21195DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 08:19:51 +1100 (EST)
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080205151216.4ff3c32a@weaponx>
References: <1200476230-14026-1-git-send-email-sr@denx.de>
	<1200477239.6755.21.camel@pasglop>
	<20080116090110.1b7b2f00@zod.rchland.ibm.com>
	<200801300716.52463.sr@denx.de> <1201734898.8146.0.camel@pasglop>
	<20080205151216.4ff3c32a@weaponx>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 08:18:06 +1100
Message-Id: <1202246286.7079.74.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, jgarzik@pobox.com,
	netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Jeff, any chance this can get into .25 soon?  I have another patch
> queued up behind this one that requires it, and I don't see it in any
> of your trees or branches.
> 
> Or, if you aren't opposed, I can take it through Paul's tree with your
> Ack.

In case my "it's fine" wasn't enough, here's an:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
