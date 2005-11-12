Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E51926872B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 08:00:24 +1100 (EST)
Date: Sat, 12 Nov 2005 13:00:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <200511122145.38409.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sat, 12 Nov 2005, Michael Buesch wrote:
> 
> Latest GIT tree does not boot on my G4 PowerBook.

What happens if you do

	make ARCH=powerpc

and build everything that way (including the "config" phase)?

So far ppc32 is still a valid architecture, and your config file makes it 
clear that you've used that. But I suspect most of the active testing has 
been done with the "powerpc" architecture compiled for 32-bit.

That said, the ppc32 tree should still work. BenH? Paul?

		Linus
