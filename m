Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4029DDDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 02:30:01 +1000 (EST)
Message-ID: <46965781.6010601@ru.mvista.com>
Date: Thu, 12 Jul 2007 20:32:01 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com>
In-Reply-To: <46955674.9090304@genesi-usa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Matt Sealey wrote:

> And I don't want to run -rt or wireless-dev for the benefit of a single

    BTW, the latest -rt has has been also released in the broken out form (at 
last!) which has "PPC gtod and highres support" section in its series file.

> feature. What I am after is something like Ingo Molnar throws out..

    One 1.5 Megabyte patch?! Bleh... thanks goodness he (or Thomas) has 
finally changed his mind about this. :-)

> single patches done the old way, not git trees. It's so much easier to
> handle and integrate for example into a Gentoo ebuild or to make a
> tarball of accumulated patches from a certain release kernel.

    This also can become a nightmare if you intend to pick up some later fixes 
only.

WBR, Sergei
