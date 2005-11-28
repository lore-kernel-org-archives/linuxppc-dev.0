Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B0110681BE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2005 22:20:44 +1100 (EST)
To: David Woodhouse <dwmw2@infradead.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Nov 2005 10:12:46 GMT."
	<1133172766.31573.14.camel@baythorne.infradead.org>
Date: Mon, 28 Nov 2005 12:01:46 +0100
Sender: wd@denx.de
Message-Id: <20051128110146.ACD2E353F54@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Make ARCH=ppc build again with new syscall path 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1133172766.31573.14.camel@baythorne.infradead.org> you wrote:
>
> There's also a third option, which _encourages_ people to port their
> platform without necessarily making it easier: just let arch/ppc break.

Please don't. This is supposed to be a "stable" kernel tree.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Monday is an awful way to spend one seventh of your life.
