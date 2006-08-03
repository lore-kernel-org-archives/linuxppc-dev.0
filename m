Return-Path: <mkravetz@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83B32679E0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 14:05:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7345FFI006647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 00:05:18 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7344qli215910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 22:04:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7344k5T000558
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 22:04:47 -0600
Date: Wed, 2 Aug 2006 21:05:06 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-ID: <20060803040506.GB3484@monkey.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
	<20060803135717.754bd37f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060803135717.754bd37f.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 03, 2006 at 01:57:17PM +1000, Stephen Rothwell wrote:
> Hi Mike,
> 
> On Wed, 2 Aug 2006 10:59:47 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
> >
> > +#else
> > +
> > +#define STACKFRAMESIZE	0
> > +#define HCALL_INST_PRECALL	nop
> > +#define HCALL_INST_POSTCALL	nop
> 
> Why even "nop", why not just blank?

At first I was concerned about macro expansion and knew a 'nop'
would be ok.  Intended to go back and try 'blank', but forgot.
I'll give it a try.

-- 
Mike
