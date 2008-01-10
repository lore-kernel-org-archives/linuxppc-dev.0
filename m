Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 29B59DDF9A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:07:54 +1100 (EST)
Date: Wed, 9 Jan 2008 21:17:23 -0600
From: Olof Johansson <olof@lixom.net>
To: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
Message-ID: <20080110031723.GA22168@lixom.net>
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:

> Heh. That's the elbow-grease of this thing.  The easy part is to get
> the core function working. The hard part is to test these various configs,
> and when they don't work, figure out what went wrong. That will take
> perseverence and brains.

This just sounds like a whole lot of extra work to get a feature that
already exists. Also, features like these seem to just get tested when the
next enterprise distro is released, so they're broken for long stretches
of time in mainline.

There's a bunch of problems like the NUMA ones, which would by far be
easiest to solve by just doing another reboot or kexec, wouldn't they?


-Olof
