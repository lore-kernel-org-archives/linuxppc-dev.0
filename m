Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5904DDF35
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:19:10 +1000 (EST)
In-Reply-To: <20070425.161309.02297897.davem@davemloft.net>
References: <1177539404.14873.199.camel@localhost.localdomain>
	<20070425.152419.110959714.davem@davemloft.net>
	<1177541265.14873.222.camel@localhost.localdomain>
	<20070425.161309.02297897.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <86094f4e887d90dbff1be6d20e5fdd5c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Consolidate of_find_property
Date: Thu, 26 Apr 2007 01:18:59 +0200
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Meanwhile any feedback on the idea of pushing all of this
> consolidation and cleanup work through one of our trees
> instead of having all of these difficult dependencies
> between the two?

Set up a branch in one of the Git repos that is for
this consolidation work only, that both the arch trees
can pull from?  The beauty with Git is that this won't
lead to merge problems :-)


Segher
