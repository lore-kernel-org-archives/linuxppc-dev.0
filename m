Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 6068D67A06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 23:48:09 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 May 2005 14:55:15 +0200."
	<200505121455.15864.david.jander@protonic.nl>
Date: Thu, 12 May 2005 15:47:54 +0200
Sender: wd@denx.de
Message-Id: <20050512134759.39EC4C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Status of isp116x driver... (on mpc8xx)? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear David,

in message <200505121455.15864.david.jander@protonic.nl> you wrote:
> 
> Ok. The sources of your driver and the one from Roman Weissgaerber look very 
> different, so I can't really tell: did you start from scratch and picked some 
> things from RW's driver, or did you modify (beyond recognition) and extend 
> his driver?

We used and extended a driver based on RW code. If you want to  folow
the history of changes in our CVS then please note thatthe driver was
renamed from drivers/usb/hcd-1161.* into drivers/usb/host/hcd-1161.*,
so for the first changes look for drivers/usb/hcd-1161.*.

> I'll work on the problem, and if I get your driver working, I'll send a patch 
> that hopefully fixes 116x support again ;-)

Thanks in advance, and good luck!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The evolution of the human race will not be accomplished in  the  ten
thousand  years  of  tame  animals,  but in the million years of wild
animals, because man is and will always be a wild animal.
                                              - Charles Galton Darwin
