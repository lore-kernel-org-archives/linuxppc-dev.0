Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD12FDE081
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:32:05 +1000 (EST)
In-Reply-To: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <fa5963726f06ede0d02002123d22fe2b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 16:31:57 +0200
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  > We don't need another ABI change to powerpc32 (still recovering=20
> from the
>  > -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
>  >
>  > ABI changes ripple everywhere (not just GCC/GLIBC) including all=20
> debuggers
>  > and performance tools. Believe me you really don't want this.
>
> Fully agreed. =A0This may have gotten lost in the discussion thread, =
but=20
> what
> Ben originally proposed was *not* an ABI change, for exactly that=20
> reason.
> We simply want to allow strictly local use of 64-bit registers for
> performance optimization purposes, while still fully complying with
> the 32-bit ABI.

Some stuff gets added to the user version of the signal
frame; is that not an ABI change?  Quite possibly a
(supposedly) compatible change, but a change anyway.


Segher
