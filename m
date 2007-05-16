Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AD06BDDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 06:29:51 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 16 May 2007 13:29:50 -0700
Message-Id: <1179347390.8132.225.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-16 at 21:55 +0200, Segher Boessenkool wrote:
> >> +			isa@f0 {
> 
> isa@1e
> 

Oh by the way, thanks for pointing this out.  Will fix.

--Wade
