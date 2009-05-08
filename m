Return-Path: <jan.neskudla.ext@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
	[217.115.75.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd001.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7417DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 21:39:21 +1000 (EST)
Subject: Re: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
From: Jan Neskudla <jan.neskudla.ext@nsn.com>
To: ext Gerhard Jaeger <g.jaeger@sysgo.com>
In-Reply-To: <200905081228.10955.g.jaeger@sysgo.com>
References: <1241705447.19689.114.camel@demuxf9c>
	<AF270294-0B90-4935-9D4A-F17EB7811CE2@kernel.crashing.org>
	<1241777196.16400.25.camel@demuxf9c>
	<200905081228.10955.g.jaeger@sysgo.com>
Content-Type: text/plain
Date: Fri, 08 May 2009 13:39:12 +0200
Message-Id: <1241782752.16400.41.camel@demuxf9c>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Gerhard, 

Yes I am sure, I know I chosen a different board than I use. I wanted to
show that this compilation problem is not influenced by our e500
patches. So I did the test on the pristine 2.6.29.1 kernel without any
external patches applied, and the problem is exactly the same when the
rionet is compiled for E500 with our patches. 

And anyway the dma_client structure is defined in the 2.6.28, but not in
the 2.6.29, so it looks to me that a rionet dma support is written for
older kernel. 

Here is the Linus tree and async_tx tree merge tree months ago
and info is:
 dmaengine: kill struct dma_client and supporting infrastructure

http://git.kernel.org/?
p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d9e8a3a5b8298a3c814ed37ac5756e6f67b6be41

                     Jan 

On Fri, 2009-05-08 at 12:28 +0200, ext Gerhard Jaeger wrote:
> Hi Jan,
> 
> On Friday 08 May 2009 12:06:35 Jan Neskudla wrote:
> [SNIPSNAP]
> > Important CONFIG options are: 
> > PPC_86xx=y
> > HPC8641_HPCN=y
> 
> you're using a e500 board (EP8548A), but the options above
> will be used when building a kernel for a e600 machine (MPC8641).
> Are you sure that is okay?
> 
> - Gerhard
