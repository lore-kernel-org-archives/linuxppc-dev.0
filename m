Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 6DF03DDF42
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 10:45:28 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC] GPIO-based flow control in the cpm_uart driver
Date: Mon, 19 May 2008 17:31:33 -0700
References: <200804151522.36884.laurentp@cse-semaphore.com>
	<20080415134007.GA17096@polina.dev.rtsoft.ru>
	<200804151547.44052.laurentp@cse-semaphore.com>
In-Reply-To: <200804151547.44052.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805191731.33193.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 April 2008, Laurent Pinchart wrote:
> Or maybe some kind of gpio_set_option() with flags specific to the 
> controller ? This could be used to enable open-drain outputs or internal 
> pull-ups for instance.

That presumes that the pin config is associated with the GPIO
controller, rather than being an independent modules...

In the cases that a platform has such an association, there
should be no problem just using a platform-specific code to
do the relevant magic.

- Dave
