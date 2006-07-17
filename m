Return-Path: <david-b@pacbell.net>
Received: from smtp114.sbc.mail.mud.yahoo.com (smtp114.sbc.mail.mud.yahoo.com
	[68.142.198.213]) by ozlabs.org (Postfix) with SMTP id 5515867BAD
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 09:04:34 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Date: Mon, 17 Jul 2006 15:57:49 -0700
References: <44B7857A.2060101@freescale.com>
	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
	<1153166894.4459.4.camel@basalt.austin.ibm.com>
In-Reply-To: <1153166894.4459.4.camel@basalt.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607171557.50368.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 17 July 2006 1:08 pm, Hollis Blanchard wrote:
>
> Seems to me that it's far better to have init code in the kernel than
> firmware.

If there's a general Linux policy on the issue, I think that'd be it.

Plus, remember that boot firmware _can't_ always be changed/bugfixed;
sometimes it can, but not as a general rule.

- Dave


> For one example, look at the x86 video card init problem 
> PowerPC Linux has. It's also far easier to fix/deploy Linux code than
> firmware code, as Li observed, and on top of that it's less work for
> non-UBoot firmwares in the future.
> 
> -Hollis
> 
