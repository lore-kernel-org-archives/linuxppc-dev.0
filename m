Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B25F367A60
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 05:05:01 +1000 (EST)
Date: Thu, 27 Apr 2006 12:04:58 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Message-ID: <20060427190458.GC11206@gate.ebshome.net>
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
	<20060427180743.GB11206@gate.ebshome.net>
	<44510E4D.5040504@icarus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44510E4D.5040504@icarus.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2006 at 11:32:45AM -0700, Stephen Williams wrote:
> Eugene Surovegin wrote:
> > There are bigger problems with 4xx support in 2.4 mainline than just 
> > missing some chips support.
> > 
> > Some parts which are already in 2.4 (e.g. ethernet driver) are of 
> > non-production quality. 
> > 
> > I can imagine Marcelo agreeing to commit 405GPr/405EP support as this 
> > change shouldn't break anything, but this will not make 2.4 support 
> > really useful for real world deployments. I think we are stuck with 
> > maintaining our own 2.4 trees with backports from 2.6. This is what I 
> > do myself of all our products (and yeah, diff between stock 2.4.32 and 
> > my internal version has already grown quite big to be acceptable for 
> > 2.4 inclusion).
> > 
> 
> Of course we are going to have to keep our own per-board trees.
> but the blatantly common stuff, like the core 405gpr support and
> certain drivers, might as well go in if the gatekeeper can be
> convinced. You and I both probably have huge drivers for custom
> devices hanging off our PPCs, with various hacks to squeeze extra
> performance out. These make our transition to 2.6 difficult, and
> surely we are not alone.

Well, personally, I don't migrate to 2.6 not because I have many custom 
drivers in my tree (if they are properly written, migration is 
relatively easy), but because 2.6 in my opinion isn't production 
ready, at least for architectures I work with. 2.6 is slower, bigger, 
is constantly being broken by huge amount of changes, etc. I spent 
enough time making 2.4 work on our hardware given limitations and 
requirements put on performance, resources etc. I just don't have time 
to go through this cycle again. And I'm not talking about PPC stuff, I 
mean mostly generic stuff - filesystems, scheduling, networking, etc.

> So 2.4 is going to be around for a while longer for us, so we might
> as well make an effort to keep the house in some sort of order. It
> serves no one to keep these fixes a secret:-)

They aren't secret, but I can understand the simple fact that 2.4 is 
closed for a new stuff, we might not like that (although I do, just 
look at the mess "stable" 2.6 is :).

There is a point in every piece of software life-cycle when you have 
to stop adding features. 2.4 is already at this point, and we should 
accept that.

-- 
Eugene
