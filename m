Return-Path: <SRS0+10f07f6f278ab718f41d+514+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8035767A2C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 00:45:55 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1106011958.4533.25.camel@gaston>
References: <1106011958.4533.25.camel@gaston>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 13:45:44 +0000
Message-Id: <1106142344.26551.517.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-01-18 at 12:32 +1100, Benjamin Herrenschmidt wrote:
> This patch updates the PowerMac sleep support. The ability to sleep is now broken
> into 2 different flags, one, "may sleep" is set for all motherboards that we know
> how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
> the video driver indicating the ability to wakeup the video card. 

Why do it like this? Drivers already have the ability to veto sleep
requests, surely?

-- 
dwmw2
