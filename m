Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2F5BDE08A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:53:45 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1599F61A-ADDE-4846-B3A9-263918995618@kernel.crashing.org>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
	<1239953907.7443.45.camel@pasglop>
	<18920.21593.737132.732053@cargo.ozlabs.ibm.com>
	<1239964860.7443.65.camel@pasglop>
	<087C29B1-39CA-4A32-81E6-533FAD21A2BC@kernel.crashing.org>
	<1239987791.7210.15.camel@pasglop>
	<1599F61A-ADDE-4846-B3A9-263918995618@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 19:51:37 +0200
Message-Id: <1239990697.7210.18.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 12:40 -0500, Kumar Gala wrote:
> > 1- In binfmt_elf.c, what happens with this statement ?
> >
> >        if (elf_read_implies_exec(loc->elf_ex, executable_stack))
> >                current->personality |= READ_IMPLIES_EXEC;
> 
> on ppc32 noting as its elf_read_implies_exec is not implemented.
> 
Right, I got confused, somewhat assumed you were on BookE 64-bit or
something :-) We just need to make 32-bit do the same as 64-bit for now
and that should do the trick.

Ben.
