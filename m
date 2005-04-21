Return-Path: <karim@opersys.com>
Received: from www.opersys.com (opersys.com [64.40.108.71])
	by ozlabs.org (Postfix) with ESMTP id 98B4567A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 03:06:12 +1000 (EST)
Message-ID: <4267E010.1050209@opersys.com>
Date: Thu, 21 Apr 2005 13:17:04 -0400
From: Karim Yaghmour <karim@opersys.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050411072406.CF0F5C108D@atlas.denx.de>
In-Reply-To: <20050411072406.CF0F5C108D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x with TQM860L
Reply-To: karim@opersys.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Wolfgang Denk wrote:
> No, in this case it is not a SDRAM issue. I  understand  that  you're
> using U-Boot on the board, and this is one of our reference platforms
> and among the best tested systems with U-Boot.
> 
> Did you apply Marcelo's patch?

... Karim returns to mailing list with brown bag on his head ...

hmm... I keep telling newbies to read the archives ... lucky for me
I actually got intelligent replies.

I figured the TQM board ought to not have that type of problem, but
I just couldn't nail down the real problem. So yes, after having
tried Marcelo's patch, things work fine. However, noe that 2.6.11.6
doesn't work out of the box for the board (i.e. doing "make
TQM860L_defconfig" doesn't yield a functional config.) I had to
manually hack a config together for it to actually work.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
