Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id E4EA8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 06:30:35 +1000 (EST)
To: "Vladimir A. Gurevich" <vag@paulidav.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 23 May 2005 06:46:23 PDT."
	<4291DEAF.1080705@paulidav.org>
Date: Mon, 23 May 2005 22:30:16 +0200
Sender: wd@denx.de
Message-Id: <20050523203021.D5033C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Microcode patches for mpc8xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Vladimir,

in message <4291DEAF.1080705@paulidav.org> you wrote:
> 
> >In our CVS tree? See the old linux-2.4 tree. We don't see  many  uses of 8xx systems recently with ucode requirements.
> >  
> >
> I am completely puzzled now.  It looks like your stable, but old 
> linux-2.4 tree has a much better selection of 8xx drivers compared to 
> the linuxppc_2_4_devel. Why is that? What do you recommend for a new 

This is because we  have  limited  resources,  and  do  those  things
(first)  where a customer is waiting (and paying) for. Not all of the
work that went into the old 2.4.4 tree was adapted  for  more  recent
versions  of  2.4  yet;  and  most  of  the 2.4 stuff got lost in 2.6
anyway.

> MPC852T-based development? Can the drivers be dropped into the newer 
> tree or more serious backporting effort is needed?

It depends. Most should work fine with minimal changes, but obviously
some effort for a code review and especially testing will be needed.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
core error - bus dumped
