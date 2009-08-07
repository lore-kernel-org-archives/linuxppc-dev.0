Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87A01B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 18:52:28 +1000 (EST)
Subject: Re: Question about powerpc branch instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <4A7BEA04.7030006@gmail.com>
References: <4A7BEA04.7030006@gmail.com>
Content-Type: text/plain
Date: Fri, 07 Aug 2009 18:52:16 +1000
Message-Id: <1249635136.24311.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-07 at 17:47 +0900, HongWoo Lee wrote:

> #1: Is there any special reason to concatenate 0b00 ?  Why 0b00 ??

Because instructions have to be aligned on 4 bytes boundaries ?

> #2: Is b similar to the jmp in x86 ? and bl is similar to the call in x86 ?

I'm not totally familiar with x86 but I "sounds" like it, though of
course they can be (ab)used in some more subtle ways.

Cheers,
Ben.

> Thanks in advance.
> 
> HongWoo.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
