Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCE9C67BE5
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 06:41:49 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0609031227220.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
	<44FB2BAF.1080509@ru.mvista.com>
	<Pine.LNX.4.64.0609031227220.27779@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <825CFFCF-6F81-4F5E-929F-54F3CA3CC022@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull powerpc.git 'merge' branch
Date: Sun, 3 Sep 2006 22:41:19 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I wrote a sparse extension that warns if an initializer tries to  
>>> initialize
>>> the same entry multiple times.
>>
>>    Ugh, I expected the C compiler to catch this... :-/
>
> Yeah, me too.

Long ago, GCC used to catch this (with an error).  C99 however
requires the overwriting behaviour.  Having a warning would be
nice though; this is http://gcc.gnu.org/PR24010 .


Segher
