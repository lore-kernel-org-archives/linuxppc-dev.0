Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id B65ACB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 04:30:11 +1000 (EST)
Date: Thu, 30 Jun 2011 14:30:03 -0400
From: Dave Jones <davej@redhat.com>
To: kevin diggs <diggskevin38@gmail.com>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
Message-ID: <20110630183002.GA9314@redhat.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
	<BANLkTikD_x3QA8_q8+444QhA39SEW6hVfg@mail.gmail.com>
	<BANLkTimjBfMBXEdH7k-6sTjb1P+Fq3-Fvg@mail.gmail.com>
	<BANLkTinciPSnJHHsMo8nfvsYS1AeDov5Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTinciPSnJHHsMo8nfvsYS1AeDov5Tw@mail.gmail.com>
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

On Thu, Jun 30, 2011 at 01:23:03PM -0500, kevin diggs wrote:
 > Hi,
 > 
 > On Wed, Jun 29, 2011 at 3:58 PM, Dmitry Eremin-Solenikov
 > <dbaryshkov@gmail.com> wrote:
 > >
 > > drivers/cpufreq/powerpc. However my current version (as suggested by Ben)
 > > goes directly to drivers/cpufreq
 > >
 > Uh ... Just curious ... why is arch specific code now being put
 > outside of the arch directories? When I wrote the 750GX stuff
 > (~2.6.28) I put in a location similar to what x86 was doing? When did
 > this change?

last release, ARM moved their cpufreq drivers. I moved the x86 ones afterwards.
There's precedent for other arch specific drivers in drivers/ too, but the
cpufreq move is a recent thing.

	Dave
