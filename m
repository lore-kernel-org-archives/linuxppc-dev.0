Message-ID: <006401c1b5c1$b9265fe0$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "None Atall" <linux_meis@yahoo.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <20020214143150.11108.qmail@web9701.mail.yahoo.com>
Subject: Re: Raven Cop 8260 Utility 
Date: Thu, 14 Feb 2002 20:40:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some flash parts have a WP* pin that "protects" the flash boot sectors only.  Often, designers will wire that input to a discrete
that can be controlled by software.

Greg Griffes
Smiths Aerospace

----- Original Message -----
From: "None Atall" <linux_meis@yahoo.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "Bruno Coudoin" <bcoudoin@anfora.fr>; "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, February 14, 2002 9:31 AM
Subject: Re: Raven Cop 8260 Utility


>
>  We have tried it to. We have reached the conclution
> that perhaps the specific flash has a hardware
> problem.
> Not even the startup monitor that BlueCat distributes
> could be writen into flash. I couldn't ether make
> ppcboot write into flash. Really strange. But it
> doesn't realy matters, since I found at least one way
> to run ppcboot. :)
>
>                  Thanks
>                    D. Meidanis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
