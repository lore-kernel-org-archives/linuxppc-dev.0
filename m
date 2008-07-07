Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E28D2DE2FE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 03:08:55 +1000 (EST)
Date: Mon, 7 Jul 2008 10:08:20 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Use new printk extension %pS to print symbols
	on oops
In-Reply-To: <20080707034436.BEA2DDDF35@ozlabs.org>
Message-ID: <alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
References: <20080707034436.BEA2DDDF35@ozlabs.org>
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



On Mon, 7 Jul 2008, Benjamin Herrenschmidt wrote:
>
> This changes the oops and backtrace code to use the new %pS
> printk extension to print out symbols rather than manually
> calling print_symbol.

Ok, I ended up committing the suppor for '%pS' early (as a series of 
smaller patches to make it clearer), just because it makes it easier for 
different people to start converthing things with the infrastructure in 
place.

But I wasn't planning on actually merging any of the conversions until 
after 2.6.26 (ie there will be no actual _users_ of '%pS' in 2.6.26)

		Linus
