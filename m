Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F172BDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 07:24:16 +1000 (EST)
Message-ID: <46B79176.6080308@freescale.com>
Date: Mon, 06 Aug 2007 16:24:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: my cpu is MPC860, kernel version is 2.6.20.14,	the kernel start
	info in the mail. why does the kernel panic?
References: <200708051854252184131@163.com> <46B743C6.1030905@freescale.com>
	<A3D38E79-6921-4C9A-BD82-5796B8995BA4@embeddedalley.com>
In-Reply-To: <A3D38E79-6921-4C9A-BD82-5796B8995BA4@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: poorbeyond <poorbeyond@163.com>,
	Linux-ppc mail list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> On Aug 6, 2007, at 8:52 AM, Scott Wood wrote:
> 
>> It wouldn't surprise me if the 8xx code has issues with PREEMPT; try
>> turning it off for now.
> 
> 
> What is your reason that 8xx would be any different?

It's just a suspicion based on my dealings with the CPM code, and the 
fact that the crash appeared to happen in the CPM ethernet driver.  It 
could be wrong, but it doesn't hurt to try without PREEMPT and see if 
the problem remains.

-Scott
