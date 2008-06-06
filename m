Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18505.10514.353016.230035@cargo.ozlabs.ibm.com>
Date: Fri, 6 Jun 2008 22:09:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
In-Reply-To: <20080606115347.GC472@cs181133002.pp.htv.fi>
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080606115347.GC472@cs181133002.pp.htv.fi>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk writes:

> BTW:
> I remember Paul wanted to get PReP under arch/powerpc/ working -
> should this be done before the big ppc removal?

I have a PReP port for arch/powerpc that works for one machine, at
least. :)  The key part is the residual to device-tree converter that
I posted some time back with a request for people to test it on their
PReP machines, but I haven't heard back from anybody.  I'm going to
post the patch shortly anyway.

Paul.
