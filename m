To: Kate Alhola <kate@iti.fi>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Jul 2004 01:20:13 +0300."
             <40E48E1D.4080404@iti.fi>
Date: Fri, 02 Jul 2004 00:29:33 +0200
Message-Id: <20040701222938.2B62CC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40E48E1D.4080404@iti.fi> you wrote:
>
> There is generic problem in these Fujitsu Display cobntrollers chips
> that their
> byte ordering (endianism) does not match with powerPC. So when used
> in 32 bit pixels the R, G and B bytes does not match normal way used by
> linux Frame buffer devices. Most of  chips allow configuration for little or
> big endian based on CPU but CoralP does not and this conversion must be
> done by software. For this reason we are offering two display controller

That's  why  we  implemented  drivers  fopr  the  Coral-P  which  are
independedt of the byte-order (and available under GPL).

> solutions, CoralP and Rage Mobility M1.  There is some good things in
> COralP and at the moment it is only chip specified for
> extended temperature range.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Until you walk a mile in another man's moccasins, you  can't  imagine
the smell.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
