Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 797E7DDE99
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 19:57:32 +1000 (EST)
Message-ID: <47172E80.6090902@genesi-usa.com>
Date: Thu, 18 Oct 2007 10:59:28 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] qemu platform, v2
References: <boot-8-00.miltonm@bga.com>
	<qemu-8-01.miltonm@bga.com>	<20070922095546.GA14185@lst.de>
	<200709221416.21580.rob@landley.net>	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>	<20071001053326.GA15132@localhost.localdomain>
	<fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
In-Reply-To: <fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 9/30/07, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Fri, Sep 28, 2007 at 06:53:28PM +0200, Segher Boessenkool wrote:
>>
>> I'm working on merging dtc into the kernel tree instead.
> 
> I'm kind of late to this party; but I have to say I disagree.  Most of
> us are doing just fine installing the dtc tool (and mkimage tool for
> that matter).  Cloning it in the kernel tree is just asking for
> divergence.

Which begs the question; why cloning?

Why can't development be MOVED to in-kernel?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
