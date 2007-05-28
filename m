Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6862EDDEBD
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 11:32:48 +1000 (EST)
Subject: Re: Please pull powerpc.git for_paulus branch (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
References: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
Content-Type: text/plain
Date: Mon, 28 May 2007 11:32:34 +1000
Message-Id: <1180315954.19517.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-05-27 at 08:58 -0500, Kumar Gala wrote:
> Linus,
> 
> If you don't mind pulling this branch that would be great.  Paul seems to
> have disappeared for a few days and I want to make sure we get these fixes
> in before 2.6.22.
> 
> If you'd like a re-base on your tree let me know.

I do mind however... this touches the hash table MMU code which is
something that needs to be acked by paulus or me at the very least.

Cheers,
Ben.
