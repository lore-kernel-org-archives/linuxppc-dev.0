Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D2BEFDDE3E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:15:07 +1000 (EST)
Message-ID: <4720DCE3.4090502@ru.mvista.com>
Date: Thu, 25 Oct 2007 22:13:55 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>	
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>	
	<47208273.8050601@ru.mvista.com>
	<fa686aa40710250721m54dda956qe7c8986416d0dfa2@mail.gmail.com>
	<4720CE3E.5030204@ru.mvista.com> <4720DD18.9000603@genesi-usa.com>
In-Reply-To: <4720DD18.9000603@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Valentine,
> 
> Please do the very minimal required to keep supporting the Efika.
> 
> As for an little endian OHCI controller on an OF bus, I would not
> consider it an impossibility. But, not having the big-endian
> property fixes this; OHCI is little-endian by default. You need
> only report "difference" in device trees, overzealous naming of
> a billion kinds of 99.99999% compatible controllers is just a
> waste of space.
> 
> I prefer the new binding to a degree. I like the big-endian property
> and I like the reporting of a standard controller type (usb-ohci
> rather than building in chip names). However by making the driver
> support only the recommending binding, we break old platforms for
> the sake of making new ones cleaner.
> 
> I wish someone would have sat down and defined the 5200 device
> tree in a design committee rather than a peer review post-commit
> system. In fact, that is a great idea, we can start this off with
> the MPC5121E right now, and get the damn thing RIGHT.
> 

OK, I'll submit a new patch in a bit.
Thanks,
Valentine.
