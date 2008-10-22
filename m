Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C215DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:29:28 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m9M1S8TB030850
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:28:08 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9M1TPCV4714510
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:29:25 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9M1TPoG031682
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:29:25 +1100
Date: Wed, 22 Oct 2008 11:12:19 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: hugetlbfs for ppc440 - kernel BUG
Message-ID: <20081022001219.GG8477@yookeroo.seuss>
References: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
	<1224622063.7654.265.camel@pasglop>
	<acbcf3840810211546s1d72dac0kabcf1285358efbdf@mail.gmail.com>
	<1224629593.7654.279.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224629593.7654.279.camel@pasglop>
Cc: kazutomo@mcs.anl.gov, linuxppc-dev@ozlabs.org, edi@linux.vnet.ibm.com,
	Satya <satyakiran@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 09:53:13AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2008-10-21 at 15:46 -0700, Satya wrote:
> > Ben,
> > Look here: http://www-unix.mcs.anl.gov/zeptoos/hugepages/
> 
> Thanks. What is the status ? Do they work fine ? Are they going to be
> re-submitted for inclusion ?

Hrm.  Last I looked at the 440 hugepage patches they appeared to have
several serious bugs (I was surprised they worked at all).  I had
meant to fix them up and push, but I never quite got around to it.
I'll have at this link later today.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
