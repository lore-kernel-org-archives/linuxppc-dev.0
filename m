Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 548B167BEC
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 07:33:46 +1000 (EST)
Date: Sun, 3 Sep 2006 14:33:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <1157318122.32334.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609031432430.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
	<1157318122.32334.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 4 Sep 2006, Benjamin Herrenschmidt wrote:
> 
> I'll send a fix later today. I don't think the read32 is used that much
> in practice, but yeah, that could have cause subtle issues on some
> machine....

Well, it's not only read32 that is broken. read8 will obviously be NULL, 
which may or may not mean that it is ever actually used.

Not knowing how this actually all ties together with users means that I 
didn't just want to check in the obvious fix..

		Linus
