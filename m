Return-Path: <Geoff.Thorpe@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6BFB1DDFC2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 05:25:33 +1000 (EST)
Message-ID: <4A1C4223.3050401@freescale.com>
Date: Tue, 26 May 2009 15:25:23 -0400
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] [PATCH 1/2 v9] powerpc: introduce macro
	spin_event_timeout()
References: <1243351302-32062-1-git-send-email-timur@freescale.com>
	<1243351302-32062-2-git-send-email-timur@freescale.com>
In-Reply-To: <1243351302-32062-2-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, geert.uytterhoeven@sonycom.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Not sure that it's the most consistent formulation, but it's definitely
better than debating indefinitely.

Cheers,
Geoff

Timur Tabi wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the condition is true
> or the timeout expires.  It returns the result of the condition when the loop
> was terminated.
> 
> This primary purpose of this macro is to poll on a hardware register until a
> status bit changes.  The timeout ensures that the loop still terminates if the
> bit doesn't change as expected.  This macro makes it easier for driver
> developers to perform this kind of operation properly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> v9: changed the macro to return the value, instead of having it passed in
[snip]
