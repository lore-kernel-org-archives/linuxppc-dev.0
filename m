Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 098EC685C1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 23:47:51 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Oct 2005 14:39:48 +0200."
	<200510271439.48990.david.jander@protonic.nl>
Date: Thu, 27 Oct 2005 15:47:35 +0200
Sender: wd@denx.de
Message-Id: <20051027134735.8E7C6353E30@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx support in 2.6 and [PATCH] USB host controller
	selection...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200510271439.48990.david.jander@protonic.nl> you wrote:
> 
> I am trying to figure out if kernel-2.6.x is already a (stable) option for 
> MPC8xx processors. Any hints? experience?
> I just rsynced DENX's git tree (cg-clone will crash on a 404 error).

Make sure to use current versions of git resp. cogito.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one instruction - from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.
