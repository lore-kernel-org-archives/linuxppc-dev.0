To: "Jean-Denis Boyer" <jdboyer@m5t.com>
Cc: "Joao Vicente" <joao.vicente@spectel.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 16:01:43 EST."
             <AB5AF73EAF23304EA1B932174137CED703042C@m5tmail.m5t.com>
Date: Wed, 12 Nov 2003 22:29:20 +0100
Message-Id: <20031112212925.2EEAAC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <AB5AF73EAF23304EA1B932174137CED703042C@m5tmail.m5t.com> you wrote:
>
> A silly question but...
> Why does U-boot report a ramdisk size of about 555kB,

He  was  using  the  old  "simple-ramdisk.PPCBoot"  image  wich   was
optimized for size. It is really just 550 kB.

> while the original from Denx's ftp server has a size of 1.33MB ?

You mean a different image (the SELF based one).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"My doctor told me to stop having intimate dinners for  four.  Unless
there are three other people."                         - Orson Welles

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
