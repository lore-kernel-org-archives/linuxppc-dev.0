To: "Brian S. Park" <brian@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: getting Linux working on IBM Walnut demo board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 May 2003 13:53:08 PDT."
             <5.1.1.6.2.20030528132553.0128a2f0@corelis.com>
Date: Wed, 28 May 2003 23:34:58 +0200
Message-Id: <20030528213503.9676EC6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Brian,

in message <5.1.1.6.2.20030528132553.0128a2f0@corelis.com> you wrote:
>
> It turned out that ELDK default setup does not have any dev files. How do I
> create all the dev files I need?

Well, I recommend you start reading the documentation now.

There is a section "7. Mounting  Target  Components  via  NFS"  which
explains  that  you  have  to  run the ELDK_MAKEDEV and ELDK_FIXOWNER
scripts.

I bet a case of beer that you didn't do that yet.

> What is the reasonable amount of flash to have for a minimally configured
> Embedded Linux system?

Depends on what you want to squeeze in. I have seen systems with just
128 kB. Obviously this is just enough for the bootloader to boot  the
kernel  over network. There are products on the market like Bluetooth
LAN Access Points or ISDN routers which have just 2 MB flash. With  4
MB  flash  you  can  set  up  a powerful system including things like
network access, web server, and Microwindows  or  Qt  embedded  based
GUIs.

I have not seen a system with less than 4 MB flash lately.

> My target will be running small (<<1MB) program which will take commands
> over TCP/IP network.
> So, I want to know how much flash memory we should put on our custom target.

If thisi s all you need (just one binary) you can plan for some 600kB
for the compressed kernel image plus some 800kB for  the  application
image.  2  MB  flash  will do for such a setup - but please note that
software tendsa to fill available space, and  I  bet  you  will  have
ideas for things to add once the box is running.

> All we need from the OS is network support. Probably using Linux is an
> overkill but since it's free. :)

Happy hacking.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
