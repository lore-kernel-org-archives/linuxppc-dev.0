Message-Id: <200010201524.RAA05556@denx.local.net>
To: "Prashant Patel" <pmpatel@trinetcommunication.com>
cc: linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Porting 2.4-test9 to MPC823 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Oct 2000 09:36:00 CDT."
             <001d01c03aa3$10f5ac30$4d1f76d8@kennedy>
Date: Fri, 20 Oct 2000 17:24:01 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Prashant,

in message <001d01c03aa3$10f5ac30$4d1f76d8@kennedy> you wrote:
>
>       I am new to this embedded linux field. So i want to know that has
> latest kernel 2.4.*  been ported to MPC 823 or not ? If not, then can

Not really the latest, but 2.4.0-test5 is running stable  on  several
MPC823E based systems (TQM823L, SPD823TS, and others).

> anybody tell  me about the porting process ( how to port kernel to MPC823 )
> ?  Anytype of help would be appreciated.

You can find our source tree including all the modifications for
TQM8xxL at

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4-2000-08-01.tar.bz2

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Far back in the mists of ancient time, in the great and glorious days
of the former Galactic Empire, life was wild, rich  and  largely  tax
free.         - Douglas Adams, _The Hitchhiker's Guide to the Galaxy_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
