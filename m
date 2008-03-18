Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 416D1DDF07
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 08:52:56 +1100 (EST)
Date: Wed, 19 Mar 2008 08:52:54 +1100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] Force 4K pages for IO addresses.
Message-ID: <20080318215254.GM6887@bakeyournoodle.com>
References: <20080317034758.GG6887@bakeyournoodle.com>
	<20080317035419.GH6887@bakeyournoodle.com>
	<20080318003434.GA671@lixom.net>
	<1205808221.26869.207.camel@pasglop>
	<20080318144511.GQ4712@localdomain>
	<1205872285.26869.251.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1205872285.26869.251.camel@pasglop>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <ntl@pobox.com>, Olof Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 07:31:25AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2008-03-18 at 09:45 -0500, Nathan Lynch wrote:
> > The ibm,drc-names property of the root node should have "HEA" strings
> > in it on systems where EHEA can potentially be present.
> 
> Ah good, I didn't know. That will force us to stick an ugly wart
> somewhere to test it though, maybe we can just force mmu_ci_restrictions
> to 1 ? Paul what do you think ?

That's not enough, mmu_io_psize also needs to be 4K.  I'll poke at doing
something platform specific today.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
