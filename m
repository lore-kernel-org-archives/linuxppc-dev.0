Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F23F67A91
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 00:40:35 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050125221517.6ec13d0f.akpm@osdl.org>
References: <1106696607.6249.18.camel@gaston>
	<20050125221517.6ec13d0f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 00:39:13 +1100
Message-Id: <1106746753.6249.51.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sven Luther <luther@gluck.debian.org>
Subject: Re: [PATCH] ppc32: (Updated) Pegasos support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-01-25 at 22:15 -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >  Here's an updated version of the pegasos support patch for ppc32, fixing
> >  a typo in the previous one.
> 
> I already sent the first version to Linus.  That's reason 42 for preferring
> incremental diffs ;)

Heh, no worries, it's a oneliner fix anyway, I'll send it tomorrow.

Ben.
