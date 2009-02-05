Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id CDFDCDDE22
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 02:23:26 +1100 (EST)
Received: by qyk14 with SMTP id 14so722274qyk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2009 07:23:25 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090205115100.GD422@sirena.org.uk>
References: <49889CFA.7070308@freescale.com> <4989F3F4.7070207@consentry.com>
	<20090205115100.GD422@sirena.org.uk>
Date: Thu, 5 Feb 2009 09:18:04 -0600
Message-ID: <ed82fe3e0902050718w1c7bfff3r883eea185b66299@mail.gmail.com>
Subject: Re: Calling wait_event_interruptible_timeout() in I2C wait functions
From: Timur Tabi <timur@freescale.com>
To: Mark Brown <broonie@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 5, 2009 at 5:51 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> This is exactly the problem for users that caused Timur to run into this
> - further up the stack we're trying to do cleanup that involves writing
> via I2C but the I2C writes error out due to the signal.

Well, there's not much discussion on this issue, so I'm going to make
the change to an uninterruptible wait and see if it fixes my problem.
If so, I'll post a patch for i2c-mpc.c and see how far I get.

-- 
Timur Tabi
Linux kernel developer at Freescale
