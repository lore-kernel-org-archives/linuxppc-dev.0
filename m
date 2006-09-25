Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 4732A67B89
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 09:45:51 +1000 (EST)
Date: Mon, 25 Sep 2006 16:46:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060925234643.GA31576@mag.az.mvista.com>
References: <20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
	<20060923081836.GA25298@mag.az.mvista.com>
	<D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
	<20060925175307.GC4971@mag.az.mvista.com>
	<4B6C3D97-1872-447A-AEE3-011E0A34298A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B6C3D97-1872-447A-AEE3-011E0A34298A@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Matt Porter <mporter@embeddedalley.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2006 at 01:40:15AM +0200, Segher Boessenkool wrote:
> >>>All I'm try to say is that "fw,address" is just like the "reg"
> >>>property
> >>>except that it holds the effective addr not the physical addr and  
> >>>the
> >>>size of the address is determined by the existence of "/cpus/64-bit"
> >>>not #address-cells.  That's all.
> 
> >Okay, fair enough.  I think you understand what I was trying to say,
> >right?  If so, do you have any objections to it?
> 
> Yes: don't call it "<whatever>address", when you immediately say it
> is more like "reg".  How about "virtual-reg"?

Anyone have a problem with "virtual-reg"?
