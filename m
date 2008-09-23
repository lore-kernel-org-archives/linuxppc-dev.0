Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6D36DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:14:52 +1000 (EST)
Subject: Re: EMAC patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080923123520.GB10837@yoda.jdub.homelinux.org>
References: <20080923123520.GB10837@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 07:14:41 +1000
Message-Id: <1222204481.8277.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 08:35 -0400, Josh Boyer wrote:
> Hi Ben,
> 
> What's your plan for the existing set of EMAC patches?  I'm just curious if
> you plan to send them through my tree (Jeff acked my set), or if you are
> going to ask Jeff to pull them into his.
> 
> I could keep an emac branch in my git tree based on whatever you think is
> best without much effort if that would help you at all.  If not, I just
> need to sort out how to land all the pieces for various board ports at one
> time.

Stick them in a branch in your tree, and if you can also pickup the
pending ones from AMCC that would be great !

Thanks,
Ben.
