Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D44B8DDF26
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:36:37 +1000 (EST)
In-Reply-To: <18010.13762.461066.706793@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
	<18010.13762.461066.706793@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29a58fd6c746d0ff8f293da97855d27c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull powerpc.git for_paulus branch (fwd)
Date: Mon, 28 May 2007 13:36:23 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> although I still don't understand
> why using .comm in assembler code is suddenly verboten...

If a kernel module refers to a common symbol things go boom.
modpost complains about it, it isn't smart enough to see
that there is no problem here.


Segher
