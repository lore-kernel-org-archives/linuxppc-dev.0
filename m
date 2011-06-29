Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A172FB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 13:43:56 +1000 (EST)
Date: Tue, 28 Jun 2011 23:43:49 -0400
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
Message-ID: <20110629034348.GB30973@redhat.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309318110.32158.520.camel@pasglop>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2011 at 01:28:30PM +1000, Ben Herrenschmidt wrote:
 > Before I comment on this last one, a quick Q. for Dave: Do you want to
 > handle this or should I merge it via powerpc.git ? (It depends on
 > another change to the arch code to expose the SCOM functions that it
 > uses, and that patch is going to be in my -next branch).

If you're carrying the dependancy, it sounds like it would make more sense
for you to carry this too. There are some changes to the Kconfig/Makefile
in drivers/cpufreq in my tree for 3.1 already, so you might get a collision
when both trees end up in next & subsequently Linus' tree. Just trivial changes though. 

 > > ---
 > >  drivers/cpufreq/Kconfig         |    5 +
 > >  drivers/cpufreq/Kconfig.powerpc |    7 +
 > >  drivers/cpufreq/Makefile        |    5 +
 > >  drivers/cpufreq/maple-cpufreq.c |  314 +++++++++++++++++++++++++++++++++++++++
 > 
 > If we're going to have a Kconfig.powerpc, should we maybe just have a
 > powerpc subdirectory instead with the driver in it ?
 > 
 > I'm happy at some later point to try moving some of my other ones there.

So far we haven't bothered with additional subarch drivers/ directories for x86/arm.
I'm not against the idea. As more archs move over, I could see drivers/cpufreq/
getting more cluttered.
 
	Dave
