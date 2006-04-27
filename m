Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 2837A67A60
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 04:54:39 +1000 (EST)
Message-ID: <44510E4D.5040504@icarus.com>
Date: Thu, 27 Apr 2006 11:32:45 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC 405GPr support in linux 2.4.32
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
	<20060427180743.GB11206@gate.ebshome.net>
In-Reply-To: <20060427180743.GB11206@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> There are bigger problems with 4xx support in 2.4 mainline than just 
> missing some chips support.
> 
> Some parts which are already in 2.4 (e.g. ethernet driver) are of 
> non-production quality. 
> 
> I can imagine Marcelo agreeing to commit 405GPr/405EP support as this 
> change shouldn't break anything, but this will not make 2.4 support 
> really useful for real world deployments. I think we are stuck with 
> maintaining our own 2.4 trees with backports from 2.6. This is what I 
> do myself of all our products (and yeah, diff between stock 2.4.32 and 
> my internal version has already grown quite big to be acceptable for 
> 2.4 inclusion).
> 

Of course we are going to have to keep our own per-board trees.
but the blatantly common stuff, like the core 405gpr support and
certain drivers, might as well go in if the gatekeeper can be
convinced. You and I both probably have huge drivers for custom
devices hanging off our PPCs, with various hacks to squeeze extra
performance out. These make our transition to 2.6 difficult, and
surely we are not alone.

So 2.4 is going to be around for a while longer for us, so we might
as well make an effort to keep the house in some sort of order. It
serves no one to keep these fixes a secret:-)

In any case, if the patches I sent are rejected, then that's that.
We'll see.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
