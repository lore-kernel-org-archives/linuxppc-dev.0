To: "Navin Boppuri" <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Weird flash problem with saveenv 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Aug 2001 16:18:23 CDT."
             <3A494DE356A49A40B37442E1E0D9F3B5063420@ptah.ad.newisys.com>
Date: Thu, 16 Aug 2001 00:23:40 +0200
Message-Id: <20010815222345.88C0D10CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A494DE356A49A40B37442E1E0D9F3B5063420@ptah.ad.newisys.com> you wrote:
>
> I have AM29LV640DU (128 uniform sectors 32kwords each) chips on my
> custom board. I have been able to do "saveenv" on all but one of my
> boards. I notice that the erase is not performed correctly and

Is that one of the flash chips that may power on in locked state  for
some  of  the sectors? [Don't have the manyal with me right now.] Did
you try writing a sector unlock sequence?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The nice thing about standards is, there are so many to choose from.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
