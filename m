Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id E38DDDDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 22:31:55 +1100 (EST)
Message-ID: <479725A4.2020401@semihalf.com>
Date: Wed, 23 Jan 2008 12:31:48 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Update TQM5200, CM5200 and Motion-PRO	_defconfig
	and .dts files
References: <20080117143024.15372.95923.stgit@hekate.izotz.org>
	<fa686aa40801170805g46eb4686y35c65276779d5244@mail.gmail.com>
	<478F984F.2030106@semihalf.com>
	<fa686aa40801171023i5188f59btfe41d09711eead09@mail.gmail.com>
	<478FD118.8030407@semihalf.com> <20080118034103.GA17898@lixom.net>
In-Reply-To: <20080118034103.GA17898@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
...
> 
> I disagree, I have one defconfig for all our boards to date. It means I
> only have one kernel to build to test on all boards, instead of having
> to build a number of different kernels. Keeping it fairly generic also
> means a customer can start out using the generic kernel in case they
> want to, and later on add their own drivers and prune out what is not
> needed.

Well, I just prefer separate defconfigs but I can live with the common
one as well, feel free to merge it as you see it fit.

Cheers,
m.
