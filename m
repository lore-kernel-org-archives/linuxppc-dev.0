Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7D09DE10A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:33:14 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2AMXBxR009070
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 15:33:12 -0700 (MST)
Message-ID: <49B6EAA4.9000803@freescale.com>
Date: Tue, 10 Mar 2009 17:33:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
In-Reply-To: <1236723118-3577-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the condition is true
> or the timeout expires.  It returns zero if the timeout expires first, non-zero
> otherwise.
> 
> This primary purpose of this macro is to poll on a hardware register until a
> status bit changes.  The timeout ensures that the loop still terminates if the
> bit doesn't change as expected.  This macro makes it easier for driver
> developers to perform this kind of operation properly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay

Why make it powerpc-specific?  This would be nice to have in 
arch-independent code.

-Scott
