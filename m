To: "Mike G." <gohas@actinium.org>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Autoboot in U-boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "18 Jul 2003 10:33:02 +0800."
             <1058495583.1183.8.camel@localhost.localdomain>
Date: Fri, 18 Jul 2003 09:10:43 +0200
Message-Id: <20030718071048.82F6EC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mike,

in message <1058495583.1183.8.camel@localhost.localdomain> you wrote:
>
> Can someone help me on this autoboot? I successfully configured the
> u-boot-0.4.0 for mpc857 custom board but somehow the bootcommand and

This is not a linux question, and thus off topic  here.  Please  post
such questions to the u-boot-users mailing list instead.

> boot arg would not run, it just skip the autoboot and goes to prompt. so
> help!!!

What do you get when you run the "printenv" command?

> #define CONFIG_BOOTDELAY	3	/* autoboot after 5 sec	*/

I consider it very bad programming style if the code and the comments
disagree.

> Reserving 512k for U-Boot at: 00f80000

Why is this 512 kB? U-Boot is needs much less memory!

> So i don't understand... where did the autoboot go??

Maybe you have a deeper  problem  with  your  environment  variables.
Where  are  they  stored? In flash? Embedded with the U-Boot image or
separate?

[Followup tu u-boot-users, please]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
What nonsense people talk about happy marriages! A man can  be  happy
with any woman so long as he doesn't love her.         -- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
