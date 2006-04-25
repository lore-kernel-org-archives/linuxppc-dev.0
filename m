Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C139679FF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 03:08:59 +1000 (EST)
Date: Tue, 25 Apr 2006 10:08:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425170857.GE20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<66B13296-80E8-4C9E-803D-F4E3D7AABB25@embeddedalley.com>
	<853005AF-8F43-454D-80E6-F39308F89A47@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <853005AF-8F43-454D-80E6-F39308F89A47@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 11:55:49AM -0500, Kumar Gala wrote:
> 
> On Apr 25, 2006, at 11:49 AM, Dan Malek wrote:
> 
> >
> >On Apr 25, 2006, at 3:49 AM, Eugene Surovegin wrote:
> >
> >>It seems some people here lost touch with reality - embedded Linux is
> >>mostly run on custom hardware, not on evaluation boards.
> >
> >This is the reason I usually mention such things.  While we all
> >want to see the new features, we have to be sensitive to the
> >real world product deployment of Linux.  While your world
> >may be a few evaluation boards that allow you to update
> >software many times a day, the real world products can't
> >afford to do that.  From my own experience, I can tell you
> >that none of the deployed systems I've worked on will
> >ever update U-Boot.  They consider this a sacred piece of
> >software such that is all else fails they can recover a
> >system remotely using U-Boot commands.  They won't
> >risk updating U-Boot in case it fails.  Making Linux dependent
> >on a particular, updated, version of U-Boot just isn't going
> >to work in most deployed systems.  Or worse, making
> >Linux dependent on U-Boot isn't necessarily popular
> >either.  For various reasons, especially when replacing
> >legacy software, some custom boot rom is often the
> >only choice.
> 
> I understand this, however these systems are not in the kernel tree  
> and thus we can only do so much for them.  I agree a shim between a  
> non-flat dev tree aware u-boot and kernel would be a good thing.   
> However, I don't see that as something I have to produce as a board  
> maintainer if I can give you and updated u-boot to use.

Kumar, you are missing our point. Let's say I packaged Motorola eval 
board and sold it as my product. So, you have this board in the tree 
but I cannot update firmware on this board. What you suggest I have to 
do so my customer can run new kernel on it? Recall the board or fly 
to the customer site with Abatron? This is just ridiculous.

-- 
Eugene
