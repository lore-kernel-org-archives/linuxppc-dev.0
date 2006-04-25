Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D2963679F0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 02:12:03 +1000 (EST)
Date: Tue, 25 Apr 2006 09:12:00 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425161200.GC20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 09:05:54AM -0500, Kumar Gala wrote:
> 
> Second, this seems normal like normal kernel development to me.  I  
> think its reasonable to pick some time frame after which we will  
> remove the support and to let everyone know what that is.  I see this  
> as no different than having a driver outside of the kernel tree and  
> having it break when APIs change.

I don't agree. This is not the same as changing _internal_ kernel API 
for a simple reason that _firmware_ was never part of the kernel and 
will never be. You seem to have an idea that's that's OK to _remove_ 
existing functionality from the kernel for no reason except your 
convenience. I think this is unacceptable. If kernel was able to boot 
on some hardware (including reference one) in the past it should be 
able to do this now even if this will require some boot shim.

-- 
Eugene
