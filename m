To: Freddy Lugo <wilflugo@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Image download problem with gdb and DBI 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Apr 2001 14:15:16 PDT."
             <20010430211516.24155.qmail@web9901.mail.yahoo.com>
Date: Mon, 30 Apr 2001 23:46:22 +0200
Message-Id: <20010430214627.AF7E02814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010430211516.24155.qmail@web9901.mail.yahoo.com> you wrote:
>
> So the image area is not downloaded, I am assuming
> this is the cause of the error.

At least it's part of the problem. Another problem might  be  missing
hardware  initialization  and  parameter  passing.  Usually I let the
firmware initialize the box and load the linux kernel...

> What I am doing wrong??
>
> Does the image (vmlinux) should be downloaded apart
> from the bootloader?  How I told gdb or bdi2000 to

No.

> download the image area?  Is there is a common recipe

The BDI2000 understands  the  Linux  image  format.  Use  the  "load"
command  (with the telnet interface) and the "image" format type (see
section 3.2.3 Part [HOST] of the BDI2000 manual).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only way to get rid of a temptation is to yield to it.
                                                        - Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
