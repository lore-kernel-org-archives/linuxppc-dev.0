To: Bruno Li <libruno@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What to change on u-boot if we want to remove SPD EEPROM? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jun 2003 18:47:45 PDT."
             <20030612014745.47244.qmail@web41509.mail.yahoo.com>
Date: Thu, 12 Jun 2003 12:03:20 +0200
Message-Id: <20030612100325.B3B5FC5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030612014745.47244.qmail@web41509.mail.yahoo.com> you wrote:
>
> We want to remove SPD EEPROM on ppc440gp to lower the
> expense. The plan is to change u-boot code to use a
> memory buffer (filled with the content of SPD EEPROM).
> Is this possible?

Yes, it is. Actually only  very  few  systems  use  memory  with  SPD
EEPROMs.

> I removed the SPD EEPROM on my ppc440gp board, and
> changed u-boot code to use a memory buffer whenever
> the code need to access SPD EEPROM, however, I found

You should implement a proper initialization function for your memory
instead.

> What extra initialization should I do when SPD EEPROM
> is missing from the system?

This depends on your hardware (type of memory etc.).


Please note that such questions ore of topic here. You will  probably
receive more / better response on the u-boot-users mailing list.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Drun'? 'm not drun'! You woudn' dare call m' drun' if I was sober!
                                     - Terry Pratchett, _Men at Arms_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
