Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81C52DDFAA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:25:03 +1000 (EST)
In-Reply-To: <20070628055626.GB10769@localhost.localdomain>
References: <20070628055626.GB10769@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8ce7fd9ddd0561e63c0f0bbfcd1e0139@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: In booting-without-of.txt,
	clarify that properties must precede subnodes
Date: Thu, 28 Jun 2007 11:24:55 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> A strict reading of the flattened device tree format defined in
> booting-without-of.txt does in fact require that all the tags defining
> properties for a node go before any definitions of subnodes, however
> it's not particularly emphasised.  Although allowing intermingled
> properties and subnodes would not be ambiguous in meaning, the kernel
> parser does currently require that properties precede subnodes.
> Furthermore, keeping this constraint makes life easier for various
> device tree scanning tools.
>
> Therefore, re-emphasise in booting-without-of.txt that this is a
> strict requirement of the flattened device tree format.

Do you want to require this for device tree source files,
too?  I think that's how the tools work right now but that's
not made explicit anywhere afaik.


Segher
