Date: Wed, 31 Mar 2004 10:03:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: John Whitney <johnw@sands-edge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331100318.B17284@home.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040331164423.GA417@gate.ebshome.net>; from ebs@ebshome.net on Wed, Mar 31, 2004 at 08:44:23AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 08:44:23AM -0800, Eugene Surovegin wrote:
>
> On Wed, Mar 31, 2004 at 10:44:25AM -0500, John Whitney wrote:
> > 2. I'd like to add 64-bit __raw_readll and __raw_writell routines to
> > io.h, done using floating-point registers.  Currently, modules such as
> > MTD (when writing to 64-bit buses) perform two 32-bit, non-atomic
> > writes, which can cause problems.  Using a floating-point register to
> > guarantee a 64-bit write is ugly, but it works.  Code for these inlined
> > routines is as follows:
>
> [snip]
>
> I wonder will it work on 4xx CPUs which don't have floating point unit?

#ifndef CONFIG_PPC_CLASSIC_FPU?

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
