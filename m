To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 + cache/dma issues 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Dec 2001 20:27:57 PST."
             <200112260427.fBQ4Rvi00224@dave.home>
Date: Wed, 26 Dec 2001 20:53:26 +0100
Message-Id: <20011226195331.BCA2B10E25@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200112260427.fBQ4Rvi00224@dave.home> you wrote:
>
> I'm running into repeated problems related to cache problems on
> ppc 8260 based hardware. The kernel is based on Montevista's 2.4.2.
> The same problem keeps coming up again and again. Here it is:

Which mask revision are you using?

Are you running in 60x bus mode, or in 8260 bus mode?

Is ther L2 cache on your board?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Language shapes the way we think, and determines what we  can  think
about."                                                 - B. L. Whorf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
