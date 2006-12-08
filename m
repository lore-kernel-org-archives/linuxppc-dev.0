Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A940767A5E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 08:55:02 +1100 (EST)
In-Reply-To: <17784.54471.964452.513068@cargo.ozlabs.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Date: Fri, 8 Dec 2006 22:54:56 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> + * A data-dependent branch followed by an isync ensures that no
>
> I think it's potentially confusing to talk about data-dependent
> branches when what the code does is a twi instruction.  Even if you
> argue that a twi is a data-dependent branch (and I disagree with that,
> since a trap is not a branch),

If you argue it is *not* a branch, where in the architecture
documentation can we find any language that gives us the
guarantee we depend on here?

> that wouldn't be obvious to a casual
> reader of the code.

True enough.

> In other words, I don't think the comment
> clarifies the situation very much.

Got anything better?  :-)

The first half of the new comment probably should go in no
matter what (it says what twi;isync do here, not how exactly
that works).


Segher
