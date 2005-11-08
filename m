Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0BB4C686F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 09:47:00 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Nov 2005 14:02:04 MST."
	<20051108210204.GP3839@smtp.west.cox.net>
Date: Tue, 08 Nov 2005 23:46:58 +0100
Sender: wd@denx.de
Message-Id: <20051108224658.98933352B33@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051108210204.GP3839@smtp.west.cox.net> you wrote:
>
> > Please do not remove stuff that is needed and used to work (in 2.4).
> 
> Note the bug in question exists in 2.4, and I think really even 2.2.

Hm... as far as I can remember (and see in the change logs) the  only
fix  we  implemented  for our 2.4.25 tree to get swapping on a MPC8xx
working was a set of bad offsets in include/asm-ppc/pgtable.h - see
http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=commit;h=e6d7a1c83f9fd5820cdb85389d6a8f2207f3641d

With this change swapping works fine for us - some of  our  customers
have been using this code in production for over two years now.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Good morning. This is the telephone company. Due  to  repairs,  we're
giving  you  advance notice that your service will be cut off indefi-
nitely at ten o'clock. That's two minutes from now.
