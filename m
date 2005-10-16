Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E0A16856C
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Oct 2005 08:44:23 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20051016102828.GA32332@localhost.localdomain>
References: <20051016102828.GA32332@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 08:43:03 +1000
Message-Id: <1129502584.7620.37.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	debian-kernel@lists.debian.org
Subject: Re: Two 32bit power3/4 build-failure patches ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-16 at 12:28 +0200, Sven Luther wrote:
> Hello,
> 
> I have here two 32bit power[34] build failure patches that the debian kernels
> has been using for some time, and which i think i did post here in the past,
> but it doesn't seem to be applied.
> 
> Well, those are 32 bit issues, and debian doesn't build anymore 32bit kernels
> of those flavours, but i guess it may be possible that some random user wants
> to build them, so it would be nice if they could be included upstream.

I think we'll be dropping 64 bits CPU support for 32 bits kernel anyway.

Ben.
