Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62EE1687E9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2005 16:02:06 +1100 (EST)
Date: Sun, 27 Nov 2005 21:02:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051128050202.GA23652@gate.ebshome.net>
References: <1133016287.4044.65.camel@baythorne.infradead.org>
	<17290.28508.336476.478948@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17290.28508.336476.478948@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Make ARCH=ppc build again with new syscall path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2005 at 01:45:48PM +1100, Paul Mackerras wrote:
>
> What do people think?  Do we make ARCH=ppc use more and more stuff
> from arch/powerpc, and delete the duplicates from arch/ppc, or do
> people want to be conservative and keep arch/ppc largely unchanged?
> (I would prefer the former, myself.)

I thought initial idea was to keep arch/ppc mostly unchanged (we are in 
"stable" series after all :), and migrate code to arch/powerpc when 
it's ready.

Personally, the amount of PPC/PPC64 changes in 2.6 make me nervous, 
looks like I'll stick with 2.4 longer than I thought for production.

-- 
Eugene
