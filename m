To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/flash and MTD 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Aug 2002 11:34:58 PDT."
             <3D540B52.8080709@redswitch.com>
Date: Fri, 09 Aug 2002 21:33:08 +0200
Message-Id: <20020809193313.21BAA10DE1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D540B52.8080709@redswitch.com> you wrote:
> To enable MTD on a board, do we still need /dev/flash? In other words,

No, this is not needed for MTD.  It's  an  alternative  interface  to
access  flash  memory; we mostly keep it for compatibility with older
projects, and because it provides some nice features like allowing to
mmap() the flash (RO).

> is there any relationship between /dev/flash and MTD? I found that only
> on Denx distribution of 2.4.4 there is such a device '/dev/flash'. Thanks.

These are two independend solutions to the task of  providing  access
to  flash  memory;  MTD is superior when you also need a block device
interface.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When you say "I wrote a program that crashed  Windows",  people  just
stare  at you blankly and say "Hey, I got those with the system, *for
free*".        - Linus Torvalds in <3itc77$9lj@ninurta.fer.uni-lj.si>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
