Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DC4767C1D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 10:15:58 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.6) with ESMTP id k9H0I19s5369858
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 10:18:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9H0JB4U236632
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 10:19:12 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9H0Bd0b015427
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 10:11:39 +1000
Date: Tue, 17 Oct 2006 10:15:42 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Subject: Re: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
Message-ID: <20061017001542.GA27359@localhost.localdomain>
References: <4532613D.1090107@cn.ibm.com>
	<20061016014334.GA30921@localhost.localdomain>
	<4533C4E9.1040504@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4533C4E9.1040504@cn.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 17, 2006 at 01:44:09AM +0800, Yao Fei Zhu wrote:
[snip]
> > 
> David, I have verified this fix, it works fine for me, Thanks. What's the status of it? Submitted?

Yes, I've sent it to Santiago Leon, the ibmveth maintainer and also to
Jeff Garzik and Andrew Morton.  It is in Andrew's -mm tree already,
haven't heard from Santiago or Jeff.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
