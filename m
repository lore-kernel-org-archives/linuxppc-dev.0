Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA05EDDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:59:51 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6R1NJ2l285870
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:23:19 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6R0x7uI249470
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:59:07 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6R0xla9026126
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:59:47 +1000
Date: Fri, 27 Jul 2007 10:52:09 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: dlopen source
Message-ID: <20070727005209.GA904@localhost.localdomain>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D78D86C2@corpexc01.corp.networkrobots.com>
	<20070726215928.GG9876@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726215928.GG9876@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Siva Prasad <sprasad@bivio.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 04:59:28PM -0500, Linas Vepstas wrote:
> On Thu, Jul 26, 2007 at 12:47:57PM -0700, Siva Prasad wrote:
> > Hi,
> > 
> > Can some one point to where I can find the source code for dlopen()
> > function.
> 
> ? Should be in glibc, right? I don't remember f it requires binutils
> pieces or not.

Yes, it's in glibc.

> (Yes, glibc is a rats nest, so understanding how it works is a whole
> nuther thing.)

Quite so.  The dynamic linking code in particular is
highly... impenetrable :(

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
