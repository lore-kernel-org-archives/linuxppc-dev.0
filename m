Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18086.41995.642267.580108@cargo.ozlabs.ibm.com>
Date: Wed, 25 Jul 2007 11:14:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: Which Git Tree to pull from?
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010895F78D@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010895F78D@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Morrison, Tom writes:

> I am a little confused here. I've been working in an older (2.6.11) 
> 
> ppc release and haven't been paying much attention to where I 
> 
> should be getting the latest / stable git tree (for powerpc).
> 
>  
> 
> I am working on an e500/8548 branch - it looks like Kumar's 
> 
> Git tree looks relatively new with lots of new patches...?

Unlike the bad old days when stuff used to accumulate for ages in
various trees without getting merged into Linus' tree, these days
stuff gets merged into Linus' tree and released in the official
releases pretty promptly.  So Linus' releases are the canonical ones
for powerpc.

I have a tree where I put stuff that will be going to Linus at the
next opportunity, but currently it is identical to Linus' tree.  It
doesn't accumulate any long-term difference from Linus' tree.

Kumar's tree currently has some stuff for 8xxx pci support that looks
to have missed the merge window that just closed.  If you want that
specific stuff you can use his tree.  That stuff should get merged
into Linus' tree once 2.6.23 has been released.

Paul.
