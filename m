Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 74E5B68882
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 10:10:06 +1100 (EST)
To: White <white@from-b.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Dec 2005 06:59:07 +0100."
	<20051208065907.26c2b1d0@White64>
Date: Fri, 09 Dec 2005 00:10:03 +0100
Sender: wd@denx.de
Message-Id: <20051208231003.3C60B353F77@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051208065907.26c2b1d0@White64> you wrote:
>
> DMA is a problem, because the implementation from Freescale use binary
> data, and has some dirty points. This would never be included in the
> mainstream kernel. Sylvian has included the new DMA .. works fine for
> FEC.

...did you try this on Rev. B (like B3) silicon?

What I cannot understand is why there were no attempots to co-operate
on this with Freescale. They offered their help here on the list...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Brain fried - Core dumped
