Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 002262BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 01:22:29 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Sep 2004 08:43:32 EDT."
	<Pine.LNX.4.60.0409280836340.9825@localhost.localdomain>
Date: Tue, 28 Sep 2004 17:22:09 +0200
Sender: wd@denx.de
Message-Id: <20040928152214.CC499C1430@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: I2C/SPI/SMC relocation patch works for both SMC 1 and 2? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409280836340.9825@localhost.localdomain> you wrote:
> 
>    but the PDF file doesn't refer explicitly to SMC1, just to the 
> generic SMC(UART).  does this mean that the same instructions to 

It relates to the SMC which parameter RAM  location  is  in  conflict
with the SPI/I2C parameter RAM, i. e. SMC1.

> relocate SMC1 could also relocate SMC2 at the same time?  the writeup 

I think it makes little sense to speculate about this without knowing
anything about how the microcode patch actually works.

> isn't clear on this and, from what i've read, it might be useful to 
> relocate SMC2 if one wants to use the reserved memory just before it 
> for, say, ethernet on SCC4 (if that's even possible).

No, this is impossible as there is no SCC4 on a MPC823/850.

>    so, short question -- i know that patch supports relocating SMC1. 
> does it also handle *both* SMC1 and SMC2?  or, perhaps, SMC2 all by 
> itself?  there's nothing in the writeup i can see that clarified this.

It is not even mentioned, so assume it is NOT supported.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I think it's a new feature. Don't tell anyone it was an accident. :-)
  -- Larry Wall on s/foo/bar/eieio in <10911@jpl-devvax.JPL.NASA.GOV>
