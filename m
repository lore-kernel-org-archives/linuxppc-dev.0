Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 699DFDE09C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:53:13 +1100 (EST)
In-Reply-To: <45B7EEB6.8060607@freescale.com>
References: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
	<4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
	<45B7D78E.5020704@freescale.com>
	<C498DBDF-5413-46CA-9A11-B625B009B53A@kernel.crashing.org>
	<45B7EEB6.8060607@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BD5D96E5-18E0-4533-85E3-D23556E0ABA3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] Make ft_node_add() accept and return NULL.
Date: Thu, 25 Jan 2007 00:53:05 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> But doesn't ft_add_node() add a node to the tree?  If so,
>> a NULL is most likely a program error. If not, some name
>> change is in order /me thinks ;-)
>
> No, it adds the node to the phandle->internal pointer lookup table  
> (or returns the existing phandle if it's already there).  And yes,  
> it could use a better name -- how about ft_node_to_phandle()?

Well a node _is_ a phandle (at some abstraction level).  How
about ft_node_get()?


Segher
