Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A120CDDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 10:18:34 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m410FmUa001943
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 20:15:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m410IUt5220960
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 18:18:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m416IUQG005902
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 00:18:30 -0600
Date: Wed, 30 Apr 2008 19:11:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Message-ID: <20080430191153.49fce28e@zod.rchland.ibm.com>
In-Reply-To: <1209599602.18023.273.camel@pasglop>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
	<EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
	<1209592794.18023.248.camel@pasglop>
	<2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
	<20080430184502.4f0c66e2@zod.rchland.ibm.com>
	<1209599602.18023.273.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 01 May 2008 09:53:22 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-04-30 at 18:45 -0500, Josh Boyer wrote:
> > > thanks.  Will take a look.  I just plan on overloading MMUCR with
> > MAS0.
> > 
> > Erg.  Why?  Please don't do that.  This is common code and MAS0
> > doesn't
> > make much sense on 4xx.  It'll be confusing to anyone that isn't aware
> > of this change.
> 
> Nah, he meant using the slot for MAS0 in the exception frame structure
> as to not have to define two different structures I suppose...

Ah, ok.  Sorry, still playing catch up on email.  I thought we were
talking about a #define.

josh
