Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E3800DDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 19:47:57 +1000 (EST)
In-Reply-To: <20070924074602.GA19514@lst.de>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
	<20070924040047.GK8058@localhost.localdomain>
	<20070924074602.GA19514@lst.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1eed199337a28687d3ea991857f9db71@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Mon, 24 Sep 2007 04:48:23 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 24, 2007, at 2:46 AM, Christoph Hellwig wrote:
> On Mon, Sep 24, 2007 at 02:00:47PM +1000, David Gibson wrote:
>> Basically because PReP support doesn't work under arch/powerpc.
>> Getting it working properly is something that should happen, but will
>> take a while.  In the meantime, getting something that's sufficient to
>> get working under just qemu's version of prep, without using the
>> abominable openhackware is a quicker path to a usable arch/powerpc
>> kernel under qemu.
>
> Sounds fair.  Care to add something like this to the Kconfig help
> text?

I suppose I could, but actually I wasn't asking for the two qemu 
patches to be merged.  Instead I was posting "here's something that 
provides minimal function for me, hope you can use it too".  For 
instance, someone should track down pci memory so that ohci and/or 
video works.  Then test the isa ne2ks, or better yet get qemu to change 
them to pci (except then it only works on the latest qemu).

I didn't put it under prep because it could be changed for the other 
qemu platforms and doesn't use any thing that makes the machine prep 
other than some memory map information.  I kept prep because I didn't 
want to deal with io to the scc on b&w G3, the other long-term platform 
(or with hackware to see if that would just boot as pmac).

milton
