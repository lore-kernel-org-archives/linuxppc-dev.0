Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41D01309.3000304@free.fr>
References: <41CEC6B0.5020106@free.fr> <1104137527.5615.20.camel@gaston>
	<41D00564.6010507@free.fr> <1104154320.23891.27.camel@gaston>
	<41D01309.3000304@free.fr>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 14:52:43 +0100
Message-Id: <1104155563.23891.29.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH uninorth3 (G5) agp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I got some lockup after adding agp support but i don't know if
> it came from my playing with the r300 (most probable
> source :)) or from the cache collision you are talking about.
> 
> Anyway it's not time to think to that :) Have good hollydays.
> 
> I will look a bit further in this to see if i can find anythings
> that may helps.

One possiblily to fix the potential issue of cache collision would be to
steal the AGP pages from the hugetlb pool (large pages) instead of small
4k pages. This would make it possible to unmap them individually from
the kernel linear mapping...

Ben.
