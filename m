To: Dustin Byford <dustin@firein.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CVS version on a Sandpoint 8240 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 06 Apr 2002 04:16:32 PDT."
             <200204060416.32920.dustin@firein.net>
Date: Sat, 06 Apr 2002 13:28:37 +0200
Message-Id: <20020406112842.866B111250@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200204060416.32920.dustin@firein.net> you wrote:
>
> Has anyone successfully run the current CVS version of ppcboot on a sandpoint

You have MUCH better chances for a useful reply to sucha question  on
the ppcboot-users mailing list...

> with an 8240.  I'm going to stard porting to my board and it is similar to
> the sandpoint design.  I would like to take advantage of the reorganization
> to use a tulip card to tftpboot.

The only area that is not completely stabilized in  the  current  CVS
version  is the new I2C code. Avoid this, and you are safe. But then,
most problems should be fixed by now anyway...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God may be subtle, but He isn't plain mean.         - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
