Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id C3FD067C36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 09:15:58 +1000 (EST)
To: Theo Gjaltema <gjalt007@chello.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Jul 2005 23:32:17 +0200."
	<42D58861.5040900@chello.nl>
Date: Thu, 14 Jul 2005 01:11:06 +0200
Sender: wd@denx.de
Message-Id: <20050713231106.387D7353B06@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8xx and ld.so problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42D58861.5040900@chello.nl> you wrote:
> 
> >>It appeard that on my mpc862 target I had also this problem. I am using
> >>ELDK3.1.1 which includes a 2.4.25 kernel.
> >
> >No, most definitely not.
> >
> I don't understand this, on
> /pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/distribution/common
> there are the sources of a 2.4.25 kernel.

Yes, sure. But most definitely you did not have *this* problem.
You have a *different* one.

> >I bet that this is a FAQ. Your SDRAM initialization is broken.
> >
> This was one of my guesses also. Since this is beyond my knowledge, I 
> had the parametes initialisation parameters compared to an other 
> platform which did not had the problems (rtos based), the same 
> parameters were used. I did not investigate it any further.

This *is* a FAQ. Please go and read the documentation.
See http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Obviously, a major malfunction has occurred."
              -- Steve Nesbitt, voice of Mission Control, January 28,
                 1986, as the shuttle Challenger exploded within view
                 of the grandstands.
