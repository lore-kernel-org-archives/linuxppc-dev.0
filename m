Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 497A167C0C
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 13:47:49 +1100 (EST)
Date: Tue, 21 Nov 2006 18:47:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17763.46950.961979.77987@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0611211843010.3338@woody.osdl.org>
References: <17763.46950.961979.77987@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 22 Nov 2006, Paul Mackerras wrote:
>
>     [POWERPC] Revert "[POWERPC] Add powerpc get/set_rtc_time interface to new generic rtc class"
>     
>     This reverts commit 7a69af63e788a324d162201a0b23df41bcf158dd.
>     
>     As advised by David Brownell:
>     
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2

Btw, when doing a web-pointer like this, _please_ don't just leave it 
hanging like that.

For one thing, there's no guarantee that the web-server will continue to 
exist, or not move around the data. And even _if_ the data still exists 
and at that address, when looking at bugs of old history it's really 
irritating to have to fire up a web browser - not to mention that maybe 
you're on an airplane or other place without internet access. Git works 
fine disconnected.

So the rule is:

 - it's perfectly _fine_ to point to web addresses for "further 
   information" (especially things like bugzilla, of course)

 - but the commit message also has to stand on its own, even _without_ the 
   pointer. So at least add a sentence about why - even if the web pointer 
   would explain it more.

So even if you just say something trivial like

	As pointed out by David Brownell, that commit was just a total 
	thinko, and could never work.

at least it doesn't leave the commit message _totally_ without any 
context.

		Linus
