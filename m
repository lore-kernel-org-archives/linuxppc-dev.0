To: c-pestka@innopsys.fr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bestcomm on mpc5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Jul 2004 15:49:10 -0000."
             <40FE9076.2080505@innopsys.fr>
Date: Wed, 21 Jul 2004 16:35:42 +0200
Message-Id: <20040721143547.39D3AC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40FE9076.2080505@innopsys.fr> you wrote:
>
>     I ' ve seen there is a Bestcomm API on the ELDK from Denx for the
> mpc5200, but I don' t know how can I use it on a linux system.
>     Is someone has ever used it, or an example to give me?

See how is used by the Linux device drivers - I'm not  sure  if  this
will serve as a good example or a bad one, though ;-)

On the CVS server there is also
arch/ppc/5xxx_io/bestcomm/doc/BestCommAPIUserGuide.pdf

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent.  They only think they are.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
