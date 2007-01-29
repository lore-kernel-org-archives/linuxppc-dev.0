Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57971DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 19:29:58 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] MSI portability cleanups
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
Date: Mon, 29 Jan 2007 01:28:39 -0700
In-Reply-To: <1170050737.26655.233.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 29 Jan 2007 17:05:37 +1100")
Message-ID: <m11wleme2w.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com,
	shaohua.li@intel.com, mingo@elte.hu,
	David Miller <davem@davemloft.net>, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> That is to make Eric's code itself cope with the HV case. I'm a bit at
> loss right now as how precisely to do it. I need to spend more time
> staring at the code after Eric latest patches rather than the patches
> themselves I suppose :-) (Eric, they don't apply out of the box on
> current git, they are against -mm ?).

Current git + gregkh-pci (Which has a couple of Michaels patches).
With current git the only problem should be context around msi_lookup_irq
which changes between the two.  But in this case the context around
an entire function being deleted doesn't matter.

Eric
