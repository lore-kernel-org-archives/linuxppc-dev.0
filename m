To: "aa aaa" <linux_powerpc@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: also the problem of creating jffs2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 May 2004 10:12:00 +0800."
             <BAY13-F27OgmJKtBmmg00011537@hotmail.com>
Date: Fri, 14 May 2004 09:23:47 +0200
Message-Id: <20040514072352.9AD50C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY13-F27OgmJKtBmmg00011537@hotmail.com> you wrote:
>
> root@172.16.115.7:/# eraseall /dev/mtd3
> eraseall: /dev/mtd3: No such device
> what is wrong ?

Maybe there is no /dev/mtd3 in your root filesyste? Check the entries
in /dev !

> MontaVista Linux 3.0, Professional Edition

Or contact MV support...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Beware of the Turing Tar-pit in  which  everything  is  possible  but
nothing of interest is easy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
