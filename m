Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Flash Driver 
Date: Tue, 14 Aug 2001 14:40:28 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B506341D@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Can I have the dd commands once again? I am not using busybox stuff.

Thank you.


-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tuesday, August 14, 2001 2:32 PM
To: Navin Boppuri
Cc: Linuxppc-Embedded (E-mail)
Subject: Re: Flash Driver


In message <3A494DE356A49A40B37442E1E0D9F3B506341C@ptah.ad.newisys.com>
you wrote:
>
> Coool!! Now I have the flash driver registering itself and telling me
> all about the number of partitions on my flash etc. etc. I have the
> flash device in the /dev directory. Now, how do I use them? I remember
> using them before using the dd command.

That's one option. If your write() calls are the same or  a  multiple
of  the erase block size, the driver performs auto-erase. You you can
just read / write it.

Attached below is a small patch against busybox to add flash_info and
flash_erase as busybox applets. [That's  part  of  SELF,  our  Simple
Embedded  Linux  Framework; I just wish I'd find the time to complete
the documentation so I could put it all up for FTP...]

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He only drinks when he gets depressed." "Why does he get depressed?"
"Sometimes it's because he hasn't had a drink."
                                     - Terry Pratchett, _Men at Arms_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
