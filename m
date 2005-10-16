Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 271AA6856C
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Oct 2005 09:06:17 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0607.wanadoo.fr (SMTP Server) with ESMTP id 02D401C00202
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Oct 2005 01:06:15 +0200 (CEST)
Date: Mon, 17 Oct 2005 00:54:09 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051016225409.GB2200@localhost.localdomain>
References: <20051016102828.GA32332@localhost.localdomain>
	<1129502584.7620.37.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129502584.7620.37.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
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

On Mon, Oct 17, 2005 at 08:43:03AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2005-10-16 at 12:28 +0200, Sven Luther wrote:
> > Hello,
> > 
> > I have here two 32bit power[34] build failure patches that the debian kernels
> > has been using for some time, and which i think i did post here in the past,
> > but it doesn't seem to be applied.
> > 
> > Well, those are 32 bit issues, and debian doesn't build anymore 32bit kernels
> > of those flavours, but i guess it may be possible that some random user wants
> > to build them, so it would be nice if they could be included upstream.
> 
> I think we'll be dropping 64 bits CPU support for 32 bits kernel anyway.

Ok, so i just drop these patches them, but i guess you can still apply them,
don't you think ? They can cause no problem, and may be useful until 32bit
kernels are dropped.

Friendly,

Sven Luther
