To: "Pascal" <pascal@ece.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Mar 2003 08:08:30 +0100."
             <000d01c2eeaf$83a4fa70$2dbe3e3e@cmh>
Date: Thu, 20 Mar 2003 09:37:06 +0100
Message-Id: <20030320083711.D8779C5451@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000d01c2eeaf$83a4fa70$2dbe3e3e@cmh> you wrote:
>
> I'm working on a motorola MPc8xx. i would like to know if it's possible
>  to run ppcboot trough an another ppcboot

Not easily. You will have to modify the code, and to do so you ned  a
pretty   good   understanding   of   what's   going   on  during  the
initialization  sequence.  And  the  modified  code  will   not   run
stand-alone.

Please you explain what you want to do, maybe there is a btter way to
do it. But please do so onthe u-boot-users mailing list. This is  off
topic here, and PPCBoot is dead anyway.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I wish I had a bronze torc for every user who didn't read the manual.
                             - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
