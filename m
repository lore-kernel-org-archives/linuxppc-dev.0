Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3AA37DE34F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 00:14:31 +1000 (EST)
Date: Thu, 14 Aug 2008 18:14:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 1/3] gpiolib: make gpio_to_chip() public
Message-ID: <20080814141428.GA32296@oksana.dev.rtsoft.ru>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<20080808161813.GA31258@polina.dev.rtsoft.ru>
	<200808141604.22287.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200808141604.22287.laurentp@cse-semaphore.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 04:04:18PM +0200, Laurent Pinchart wrote:
> On Friday 08 August 2008, Anton Vorontsov wrote:
> > We'll need this function to write platform-specific hooks to deal
> > with pin's dedicated functions. Quite obviously this will work only
> > for the platforms with 1-to-1 GPIO to PIN mapping.
> > 
> > This is stopgap solution till we think out and implement a proper
> > api (pinlib?).
> 
> How do you support reverting the GPIO mode to non-dedicated ?

As we always do with the GPIO API: gpio_direction_*() calls.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
