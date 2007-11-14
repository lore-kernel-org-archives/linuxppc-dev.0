Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A5797DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 21:15:27 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 14 Nov 2007 11:15:24 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1195034697.28865.34.camel@pasglop>
Message-ID: <20071114101524.297880@gmx.net>
MIME-Version: 1.0
References: <20071108214723.135260@gmx.net>	 <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net>	 <1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net>	 <1194753340.21340.24.camel@pasglop>
	<20071113212320.85840@gmx.net>	 <1194990218.28865.1.camel@pasglop>
	<20071113220655.85840@gmx.net>	 <1194997072.28865.5.camel@pasglop>
	<20071114093939.297890@gmx.net> <1195034697.28865.34.camel@pasglop>
Subject: Re: Kernel locks up after calling kernel_execve()
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 14 Nov 2007 21:04:57 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: Kernel locks up after calling kernel_execve()

> On Wed, 2007-11-14 at 10:39 +0100, Gerhard Pircher wrote:
> > Yeah, the northbridge hates the M bit! Thus the AmigaOne platform code
> > masks out the CPU_FTR_NEED_COHERENT flag and disables the L2 cache
> > prefetch engines (I don't care about the performance loss).
> > I couldn't find any other code that sets the M bit, except for huge
> > TLB
> > page support, but isn't that only for PPC64?
> 
> Right, it's only 64 bits. You've double checked nothing broke the M bit
> thing ? In which case, I don't know what else...
Yes, I did. Otherwise the machine dies much earlier in the boot process.

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
