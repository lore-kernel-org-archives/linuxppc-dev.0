Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by ozlabs.org (Postfix) with SMTP id A9182DDEC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 07:51:17 +1100 (EST)
In-Reply-To: <1199650065.7291.81.camel@pasglop>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<1199650065.7291.81.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
Date: Sun, 6 Jan 2008 12:44:33 -0800
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2008, at 12:07 PM, Benjamin Herrenschmidt wrote:

> It's nice to see somebody digging in that scary math emu stuff. If you
> could also get rid of the warnings, it would be perfect :-)

Yes, it is :-)  I didn't think it would have a life beyond MPC8xx.

> .... that this code was lifted from
> somewhere else (glibc ? gcc soft-float ?),

It seems like a lifetime ago....  I copied the framework
from Sparc, and the internals from gcc soft-float.  I didn't
change any of the internal emulation functions (hence,
some of the warnings), just the calling interface.

While it's convenient, I still don't think kernel float
emulation should be a solution.  The tools should
generate soft-float for the applications and libraries.

Thanks.

	-- Dan
