Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B416A67B74
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 14:49:32 +1000 (EST)
Date: Wed, 30 Aug 2006 21:49:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0608302147230.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
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



On Thu, 31 Aug 2006, Paul Mackerras wrote:
> 
>     [POWERPC] Fix problem with time not advancing on 32-bit platforms

I had just previously applied this to my tree, but apparently you used the 
exact same patch, so it all merged fine.

Pulled and pushed out,

		Linus
