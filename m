Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 804EBDDF7E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 00:46:48 +1000 (EST)
Date: Thu, 22 May 2008 16:46:39 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH 1/2] USB: isp1760: Assign resource fields before adding hcd
Message-ID: <20080522144639.GA26410@Chamillionaire.breakpoint.cc>
References: <1211405300.13845.627.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1211405300.13845.627.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Nate Case | 2008-05-21 16:28:20 [-0500]:

>This fixes the bogus "io mem 0x00000000" message printed
>during driver init due to hcd->rsrc_start being assigned after
>the call to usb_add_hcd().
>
>Signed-off-by: Nate Case <ncase@xes-inc.com>
I saw this and was wondering why it was correct in other places like
/proc/iomem :)

Acked-by: Sebastian Siewior <bigeasy@linutronix.de>
