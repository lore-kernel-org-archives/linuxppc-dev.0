Return-Path: <erik@dd.nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id 697A2DDF30
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 18:29:15 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 18:29:15 +1000 (EST)
Received: from bohr.dd.nec.com.au (bohr.dd.nec.com.au [172.31.20.11])
	by deer.dd.nec.com.au (8.12.5/8.12.5/Debian-1) with ESMTP id
	l5S8RAwX015483
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Jun 2007 18:27:10 +1000
Received: from dvalin ([172.31.20.70])
	by bohr.dd.nec.com.au (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	l5S8RAil026309
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Jun 2007 18:27:10 +1000
Date: Thu, 28 Jun 2007 18:36:24 +1000
To: linuxppc-embedded@ozlabs.org
Subject: Re: ARCH=ppc or ARCH=powerpc
Message-ID: <20070628083624.GE8794@dd.nec.com.au>
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
	<2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
	<20070628074430.GC8794@dd.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070628074430.GC8794@dd.nec.com.au>
From: erik@dd.nec.com.au (Erik Christiansen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 28, 2007 at 05:44:30PM +1000, Erik Christiansen wrote:
> Encountering a kernel build error with ARCH=ppc, after configuring as much as
> possible for MPC8248, I've just tried ARCH=powerpc on linux-2.6.21.5, with this
> slightly scary result:

Oh dear. Please excuse the noise. That was clearly acute lack of
familiarity with menuconfig.   <blush>

Minus fingerfumbling, ARCH=powerpc starts to build, before coughing up a
bunch of compiler errors:

cpm2_common.c:63: error: 'CPM_MAP_ADDR' undeclared

Is that due to this patch not being accepted?:
   http://patchwork.ozlabs.org/linuxppc/patch?id=8891

If the patch's "State Superseded" means something else fixes the build
failure, then how could I lay my grubby paws on that little gem?

Erik
