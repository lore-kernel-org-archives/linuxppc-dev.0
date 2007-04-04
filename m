Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id 9FA39DDEC3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 17:58:23 +1000 (EST)
Date: Wed, 4 Apr 2007 11:58:13 +0400
From: Igor Marnat <marny@rambler.ru>
Message-ID: <15978422796.20070404115813@rambler.ru>
To: glikely@gmail.com, "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ppchameleon_early_serial_map hidden under #ifdef
	CONFIG_SERIAL_8250
In-Reply-To: <528646bc0704022305s307c299hcdab589fa7e1776b@mail.gmail.com>
References: <05625250.20070403092134@rambler.ru>
	<528646bc0704022305s307c299hcdab589fa7e1776b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Igor Marnat <marny@rambler.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Grant and List!

GL> This is just ugly, but not because of your patch.  External function
GL> prototypes that aren't pulled from header files can lead to all kinds
GL> of wierdness.  Since the code is already ugly and dangerous, I
GL> wouldn't even bother with adding the #ifdef around it.

Well, should I change the patch or it will be applied as is?

Best regards,
Igor Marnat                            mailto:marny@rambler.ru
