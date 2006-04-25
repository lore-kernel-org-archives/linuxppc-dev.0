Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B04B679FB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 04:01:21 +1000 (EST)
Date: Tue, 25 Apr 2006 11:01:19 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425180119.GF20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<66B13296-80E8-4C9E-803D-F4E3D7AABB25@embeddedalley.com>
	<853005AF-8F43-454D-80E6-F39308F89A47@kernel.crashing.org>
	<20060425170857.GE20228@gate.ebshome.net>
	<BEC38EF6-326E-4ED1-8F02-4A3FA928908F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BEC38EF6-326E-4ED1-8F02-4A3FA928908F@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 12:39:45PM -0500, Kumar Gala wrote:
> >Kumar, you are missing our point. Let's say I packaged Motorola eval
> >board and sold it as my product. So, you have this board in the tree
> >but I cannot update firmware on this board. What you suggest I have to
> >do so my customer can run new kernel on it? Recall the board or fly
> >to the customer site with Abatron? This is just ridiculous.
> 
> If you are doing this, you should have someone for your customers to  
> update the firmware.

Wow, I want to live in that world you seem to be living. I rest my 
case.

> What happens when Freescale finds an errata that requires a new 
firmware image?

I find a way to handle it in the kernel. So far, I was quite 
successful in doing this for 440 (I just sent a patch for one of such 
erratum upstream).

> I understand the point for a custom solution, however I think make  
> the same claim for a reference board is silly, until someone can show  
> me a real case in which its not feasible to update the firmware.

I can imagine doing this for CDS for example. 

Kumar, you seem to insist that it's easy to update firmware in field, 
it's not. I've been doing this stuff for many years, Dan - probably 
for decades, but you refuse to listen. 

What you will end up with is that that small amount of embedded people 
who bother to contribute something back will stop doing this. We are 
more than capable of maintaining our internal kernel trees :).

-- 
Eugene
