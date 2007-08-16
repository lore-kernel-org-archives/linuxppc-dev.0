Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA2ACDDE9C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:23:52 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7G5RKwt319054
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:27:20 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7G5No9h1298514
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 15:23:50 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7G6NnGv030893
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 16:23:50 +1000
Date: Thu, 16 Aug 2007 15:12:56 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [Documentation] Page Table Layout diagrams
Message-ID: <20070816051256.GF3540@localhost.localdomain>
References: <1186598865.23817.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186598865.23817.76.camel@localhost.localdomain>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 01:47:45PM -0500, Adam Litke wrote:
> Hello all.  In an effort to understand how the page tables are laid out
> across various architectures I put together some diagrams.  I have
> posted them on the linux-mm wiki: http://linux-mm.org/PageTableStructure
> and I hope they will be useful to others.  
> 
> Just to make sure I am not spreading misinformation, could a few of you
> experts take a quick look at the three diagrams I've got finished so far
> and point out any errors I have made?  Thanks.

Nice.  Didn't spot any innaccuracies.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
