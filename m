Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0DA2EDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:43:23 +1100 (EST)
Message-ID: <474DFD15.603@freescale.com>
Date: Wed, 28 Nov 2007 17:43:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: Timers on mpc8248 etc...
References: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
In-Reply-To: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> I've got a routine that needs to delay for X microseconds, this is a
> must.  The command after schedule_timeout must has to wait for the HW
> to complete a task that takes X microseconds.
> 
> I would think that one way to do this is with a simple
> schedule_timeout.  But in the example below, the time that passes from
> run1() to dontrun() is far less than 3.2 msecs.  Infact, sometimes its
> ~ 800 micros according the a analyzer looking at points triggered in
> run1() and donrun().  Could this be a configuration problem with the
> timer/interrupt that generates the jiffies?

Are you sure the timebase frequency is set correctly in the device tree?

-Scott
