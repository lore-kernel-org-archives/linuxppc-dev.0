Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B2B6767B54
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 06:41:40 +1000 (EST)
Date: Mon, 31 Jul 2006 13:41:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull powerpc.git 'merge' branch
In-Reply-To: <17613.38710.609255.581840@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0607311338420.4168@g5.osdl.org>
References: <17613.38710.609255.581840@cargo.ozlabs.ibm.com>
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



On Mon, 31 Jul 2006, Paul Mackerras wrote:
> 
> Please do a pull from the "merge" branch of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Please change your "please pull" script so that the branch-name is 
mentioned at the end of the same line as the repo name.

Not only does that make cut-and-paste work, it avoids the easy mistake of 
not noticing the branch-name and instead merging the "master" branch by 
mistake (which I did at first, and ended up fixing up a merge conflict 
until I noticed that it wasn't even what you asked me to pull..).

Ok?

		Linus
