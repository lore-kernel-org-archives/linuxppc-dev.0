Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09D46DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 01:58:11 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id lB4Ew5ac006561
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 01:58:05 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB4F1jbB280852
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 02:01:46 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB4EvrwT023426
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 01:57:54 +1100
Message-ID: <47556AE5.8010708@linux.vnet.ibm.com>
Date: Tue, 04 Dec 2007 20:27:41 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.24-rc3-git2 softlockup detected
References: <474D0AAC.5010005@linux.vnet.ibm.com>
	<20071127225328.9e3f3827.akpm@linux-foundation.org>
	<474D15FF.5080508@linux.vnet.ibm.com>
	<20071127232552.ad16e95c.akpm@linux-foundation.org>
	<474E5CAC.9000108@linux.vnet.ibm.com>
	<20071129003533.54b4b20e.akpm@linux-foundation.org>
	<20071130063929.GD2754@fattire.cabal.ca>
	<20071129230047.1b482562.akpm@linux-foundation.org>
	<20071129230204.8698f47e.akpm@linux-foundation.org>
	<474FBB86.5000004@linux.vnet.ibm.com>
	<20071204122005.GA27286@elte.hu>
In-Reply-To: <20071204122005.GA27286@elte.hu>
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-scsi@vger.kernel.org,
	Matthew Wilcox <willy@debian.org>, LKML <linux-kernel@vger.kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
>>> So 2.6.24-rc3 was OK and 2.6.24-rc3-git2 is not?
>> Yes, the 2.6.24-rc3 was Ok and this is seen from 2.6.24-rc3-git2/3/4.
> 
> just to make sure: this is a real lockup and failed bootup (or device 
> init), not just a message, right?
> 
> 	Ingo
> --

Hi Ingo,

This softlockup is seen in the 2.6.24-rc4 either and looks like a message because 
this is seen while running tbench and machine continues running other test's after 
the softlockup messages and some times seen with the bootup, but the machines reaches the 
login prompt and able to continue running tests.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
