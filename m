Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BDD9DDF86
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 03:29:18 +1000 (EST)
Date: Sun, 27 Jul 2008 10:26:08 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] powerpc: Use new printk extension %pS to print symbols
	on oops
In-Reply-To: <1217137231.1769.33.camel@shinybook.infradead.org>
Message-ID: <alpine.LFD.1.10.0807271025490.3486@nehalem.linux-foundation.org>
References: <20080707034436.BEA2DDDF35@ozlabs.org>
	<alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
	<1217137231.1769.33.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 27 Jul 2008, David Woodhouse wrote:
> 
> Out of interest, why is it %pS and not %Sp? Shouldn't the modifier come
> first? What if we want to print a pointer immediately followed by a
> capital S?

Try it. 

			Linus
