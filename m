To: Arun Dharankar <ADharankar@attbi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: lwIP on PPCBoot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Apr 2003 16:21:55 EDT."
             <200304151621.55214.ADharankar@ATTBI.Com>
Date: Tue, 15 Apr 2003 23:14:00 +0200
Message-Id: <20030415211405.AE0C2C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200304151621.55214.ADharankar@ATTBI.Com> you wrote:
>
> Anyone ported lwIP (http://www.sics.se/~adam/lwip/
> or http://savannah.nongnu.org/projects/lwip/) to PPCBoot?

None that I know of.

> I am exploring ideas to use this on PPCBoot/U-Boot.

What for? U-Boot is  a  boot  loader.  You  don't  need  things  like
multi-tasking or a ful TCP/IP stack or java support in a boot loader.
If  your applications needs such services, then use U-Boot to boot an
OS. I recommend to use tools for the  purpose  for  which  they  were
designed  for. Yes, you can use a microscope as a hammer, but I don't
think it's a good idea. YMMV.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God made the integers; all else is the work of Man.       - Kronecker

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
