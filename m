To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: booting from flash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Mar 2002 14:42:24 EST."
             <D73A25AA6E54D511AD74009027B1110F0F30E0@ORION>
Date: Mon, 04 Mar 2002 20:54:59 +0100
Message-Id: <20020304195504.640F9109E9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <D73A25AA6E54D511AD74009027B1110F0F30E0@ORION> you wrote:
>
> Is there a simple way to boot embedded linux from flash?  I've been able to
> easily compile and execute from RAM but when I try from flash the kernel can
> not use the initrd and it panics.

It would be helpful to know what board you have, and  which  formware
you're using.

So all I can say is: yes, there is a  simple  way.  Probably  it's  a
two-step  solution.  The first step is installing PPCBoot, the second
step is using the "bootm" command.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is dangerous to be sincere unless you are also stupid.
                                                - George Bernard Shaw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
