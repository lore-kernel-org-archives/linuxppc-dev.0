To: Kate Alhola <kate@iti.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 supported in Linux kernel (devel tree from DENX)? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Sep 2003 11:51:34 +0300."
             <3F5EE616.2070305@iti.fi>
Date: Wed, 10 Sep 2003 11:00:43 +0200
Message-Id: <20030910090048.453D9C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kate,

in message <3F5EE616.2070305@iti.fi> you wrote:
>
> How about internal PCI bridge support for 8xxx series ? I have tried

Supported and working on several boards.

> found it for
> 826x/825x/8270 QUCC-II but it seems that there is just promises around
> but i have not
> even found souce of development/alpha version.

You must have missed it. See for example the configurations  for  the
"ATC" or "PM825" boards (both with MPC8250) in our kernel tree.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent.  They only think they are.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
