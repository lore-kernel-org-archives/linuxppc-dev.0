Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24F7FDDFD7
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:44:56 +1100 (EST)
In-Reply-To: <20070129201157.GD13485@ld0162-tx32.am.freescale.net>
References: <20070129201157.GD13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50C1999E-B350-415F-B014-0009A3986FA1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 04/18] bootwrapper: Add ft_root_node().
Date: Tue, 30 Jan 2007 20:44:45 +0100
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

> Clean up some of the open-coded data structure references by  
> providing a
> function to return a pointer to the first node in the tree.  This  
> is only

Nit: s/first node/root node/

> used in high-level functions trying to access the beginning of the  
> tree,
> not in low-level code that is actually manipulating the data  
> structure.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
