Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F867DDD08
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 22:06:40 +1000 (EST)
Message-ID: <4696197E.9010002@genesi-usa.com>
Date: Thu, 12 Jul 2007 13:07:26 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com>
	<20070712064115.GO10345@bakeyournoodle.com>
In-Reply-To: <20070712064115.GO10345@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Tony,

What does "isn't quite right yet" mean? Broken, acts funny, or just
a messy patch?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Tony Breeds wrote:
> On Wed, Jul 11, 2007 at 11:15:16PM +0100, Matt Sealey wrote:
>  
>> And I don't want to run -rt or wireless-dev for the benefit of a single
>> feature. What I am after is something like Ingo Molnar throws out..
>> single patches done the old way, not git trees. It's so much easier to
>> handle and integrate for example into a Gentoo ebuild or to make a
>> tarball of accumulated patches from a certain release kernel.
> 
> Hi Matt,
> 	In the near future I will have something that I can pass around
> for review.  Which will be a quilt series of about 5 patches (based on
> mainline).  I'll make sure to include you in the reviewers list.  At
> this stage I'd hope they'll be in 2.6.24.
> 
> I have HRT in a state where you can enable it and it works, but NO_HZ
> isn't quite right yet.
> 
> Yours Tony
> 
>   linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
>   Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
> 
