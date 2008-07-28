Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3861DDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:22:41 +1000 (EST)
Subject: Re: gigantci pages patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080727201735.0b141250.akpm@linux-foundation.org>
References: <20080711174515.1aacf83b.sfr@canb.auug.org.au>
	<20080722033417.GD14888@yookeroo.seuss>
	<4886418C.9050704@linux.vnet.ibm.com>
	<20080728010757.GF11318@yookeroo.seuss>
	<20080727201735.0b141250.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 13:19:28 +1000
Message-Id: <1217215168.11188.159.camel@pasglop>
Mime-Version: 1.0
Cc: npiggin@suse.de, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jon Tollefson <kniht@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-27 at 20:17 -0700, Andrew Morton wrote:
> s
> 
> OK.  Although I'm no longer sure what patches "for the series" refers to.
> 
> I am currently retaining
> 
> powerpc-implement-pte_special.patch
> powerpc-implement-pte_special-update.patch
> powerpc-lockless-get_user_pages.patch
> 
> and frankly I'm unsure what the status is.  I have a note that benh had
> concerns about powerpc-lockless-get_user_pages.patch, but iirc they
> were waffly and vague ;)
> 
> So I'm thinking I'll stick these patches onto my send-to-ben list.

Ok, send the latest ones you have to me, and I'll sort things you.

Cheers,
Ben.
