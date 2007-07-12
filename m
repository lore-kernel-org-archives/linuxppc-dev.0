Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A213DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 06:07:39 +1000 (EST)
Message-ID: <46968A39.8080905@genesi-usa.com>
Date: Thu, 12 Jul 2007 21:08:25 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com> <46965781.6010601@ru.mvista.com>
In-Reply-To: <46965781.6010601@ru.mvista.com>
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


Sergei Shtylyov wrote:
> Hello.
> 
> Matt Sealey wrote:
> 
>> And I don't want to run -rt or wireless-dev for the benefit of a single
> 
>    BTW, the latest -rt has has been also released in the broken out form
> (at last!) which has "PPC gtod and highres support" section in its
> series file.

Hm okay.

>> feature. What I am after is something like Ingo Molnar throws out..
> 
>    One 1.5 Megabyte patch?! Bleh... thanks goodness he (or Thomas) has
> finally changed his mind about this. :-)

Good point, but at least it was nice and self-contained and not mindlessly
interdependant on other minor fixes. I think if you are going to patch in
a feature that feature should be a feature. Not 8 bugfixes and 8 seperate
minifeatures which cooperate to bring in a whole, especialy as a lot of
them are so interdependant that they would not have any effect or maybe
even break things on their own :)

>> single patches done the old way, not git trees. It's so much easier to
>> handle and integrate for example into a Gentoo ebuild or to make a
>> tarball of accumulated patches from a certain release kernel.
> 
>    This also can become a nightmare if you intend to pick up some later
> fixes only.

Indeed, but you trade off one for the other in everything :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
