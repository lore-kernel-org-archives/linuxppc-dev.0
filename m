Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF469DE124
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Dec 2008 12:30:05 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBD1TFMR016045
	for <linuxppc-embedded@ozlabs.org>; Fri, 12 Dec 2008 20:29:15 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBD1Tx7l172522
	for <linuxppc-embedded@ozlabs.org>; Fri, 12 Dec 2008 20:29:59 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBD1TwA4016793
	for <linuxppc-embedded@ozlabs.org>; Fri, 12 Dec 2008 20:29:58 -0500
Date: Fri, 12 Dec 2008 20:29:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "sarah.ddff" <sarah.ddff@gmail.com>
Subject: Re: two linux 2.6 kernels on two ppc405 (xupv2p) ?
Message-ID: <20081212202952.48ef12c3@zod.rchland.ibm.com>
In-Reply-To: <20978466.post@talk.nabble.com>
References: <20978466.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 12 Dec 2008 08:13:26 -0800 (PST)
"sarah.ddff" <sarah.ddff@gmail.com> wrote:

> 
> Hi all,
> I want to implement a multiprocessor system managed by a linux kernel on the
> xupv2p.
> I knwo that there is no cache coherency between the two ppc405 cores.
> Consequently,
> SMP linux can not be used.
> So the only solution is to install two linux kernels, each on a ppc
> processor,
> and to make them communicate with shared memory.
> My questions are:
> does someone succeed in doing this?
> Is it possible to do this ?

AMCC has created a dual-460GT board called Arches.  I have no idea how
it actually works because it faces the same issues a dual-405 board
would, but apparently someone must use it somewhere.

Basic Arches support is in the kernel, but it's only for a single
processor from what I can see.

josh
