To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4.18 kernel mpc8xx pcmcia 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Sep 2003 15:18:55 EDT."
             <3439AB3A99ECD5409F3A52ACF814744D158D81@norcom2.norcom.net>
Date: Wed, 10 Sep 2003 21:40:16 +0200
Message-Id: <20030910194021.7B6BEC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3439AB3A99ECD5409F3A52ACF814744D158D81@norcom2.norcom.net> you wrote:
>
> I am using 2.4.18 kernel on a mpc8xx based board. I am trying to get pcmcia
> working. I have downloaded pcmcia-cs and also looked at drivers/pcmcia
> directory. I am confused about as to how to proceed? Any pointers please?

See http://www.denx.de/twiki/bin/view/DULG/FlashDisks and
http://www.denx.de/twiki/bin/view/DULG/ConfigureLinuxForPCMCIACardsUsingTheCardServicesPackage

Our ELDK contains pre-built versions of pcmcia-cs (and other  things,
like wireless-tools etc.)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How long does it take a  DEC  field  service  engineer  to  change  a
lightbulb?       It depends on how many bad ones he brought with him.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
