To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ramdisk trivial question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Nov 2003 11:25:02 +0100."
             <005601c3b275$39446fd0$0700a8c0@pc005>
Date: Mon, 24 Nov 2003 12:49:36 +0100
Message-Id: <20031124114941.6ADAFC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gianfranco,

in message <005601c3b275$39446fd0$0700a8c0@pc005> you wrote:
>
> The question is: The ELDK 2.01 package (which is currently being used in our
> system) is too large to be fitted into a ramdisk, while the minimum
> filesystem does not allow to be used in our midrange application. Does

What do you mean with "the minimum filesystem does not  allow  to  be
used" ?

> anybody have or can indicate where can we find an almost complete filesystem
> scheme (for instance based on the ELDK packages)?

The ELDK contains the SELF package  (SELF  =  Simple  Embedded  Linux
Framework)  which  is  intended  as  a  building  stone  for your own
application images. Instructions how to add files and/or  change  the
size  of  the  filesystem and how to generate different image formats
(ramdisk, cramfs, JFFS2) can be fund in the DULG. See especially

http://www.denx.de/twiki/bin/view/DULG/HowToIncreaseSizeOfRamdisk
http://www.denx.de/twiki/bin/view/DULG/HowToAddFiles

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
