Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 2FD90679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 19:34:15 +1000 (EST)
To: Pantelis Antoniou <panto@intracom.gr>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 16 Jun 2005 09:42:35 +0300."
	<42B11F5B.2050706@intracom.gr>
Date: Thu, 16 Jun 2005 11:33:48 +0200
Sender: wd@denx.de
Message-Id: <20050616093353.8C0ECC1510@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42B11F5B.2050706@intracom.gr> you wrote:
> Let me hop in here...
> 
> Have you thought about breaking up the structures per
> cpm peripheral?

I complained about this a long time ago (when  Kumar's  patches  were
checked  in for 2.4.26 which broke compatibility between 8xx and 8260
systems).

> Some registers are unique for each processor family, but
> others are (almost) common to all.

It would indeed be beneficial if common parts used common definitions
and names.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When you die, the first thing you lose is your life. The  next  thing
is the illusions.                       - Terry Pratchett, _Pyramids_
