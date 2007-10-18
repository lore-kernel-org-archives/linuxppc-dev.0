Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C30F3DDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 03:19:32 +1000 (EST)
In-Reply-To: <47172E80.6090902@genesi-usa.com>
References: <boot-8-00.miltonm@bga.com>
	<qemu-8-01.miltonm@bga.com>	<20070922095546.GA14185@lst.de>
	<200709221416.21580.rob@landley.net>	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>	<20071001053326.GA15132@localhost.localdomain>
	<fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
	<47172E80.6090902@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <440d60abf1ef533839cf5d9beb0584c9@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Thu, 18 Oct 2007 12:19:26 -0500
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 18, 2007, at 4:59 AM, Matt Sealey wrote:
> Grant Likely wrote:
>> On 9/30/07, David Gibson <david@gibson.dropbear.id.au> wrote:
>>> On Fri, Sep 28, 2007 at 06:53:28PM +0200, Segher Boessenkool wrote:
>>>
>>> I'm working on merging dtc into the kernel tree instead.
>> I'm kind of late to this party; but I have to say I disagree.  Most of
>> us are doing just fine installing the dtc tool (and mkimage tool for
>> that matter).  Cloning it in the kernel tree is just asking for
>> divergence.
>
> Which begs the question; why cloning?
>
> Why can't development be MOVED to in-kernel?

Because we don't put userspace testsuites there for one.

And its a stand alone tool and should have its own packaging for a 
second (ie the kernel provides the kernel and modules, but not random 
user space utilities, in its tarbal).

If we say only some boards or ports are special and need to build then 
I would vote for shipping asm files.  If we think we need to build any 
random embedded platform without installing dtc then we should merge 
dtc.

PS the proposed kbuild integration is wrong; it should build it in the 
subdirectory.

milton
