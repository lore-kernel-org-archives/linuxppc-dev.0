To: simitel0299 <simitel0299@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where get the Linux Init Source for 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Mar 2001 14:21:36 +0800."
             <20010330062136.3295.qmail@sina.com>
Date: Fri, 30 Mar 2001 09:43:18 +0200
Message-Id: <20010330074323.CB26928827@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010330062136.3295.qmail@sina.com> you wrote:
>
> Would you like to provide me with the source codes of LinuxPPC
> initialization for MPC8xx, just from the CPU PWRUP Reset to the OS
> and finally to the Application ? If available, the corresponding
> documents will be OK!

It seems you are  looking  for  PPCBoot,  the  Open  Source  firmware
project  for  embedded  PowerPC  systems.  It's  running  on many PPC
systems, including 8xx, 82xx and 40x CPUs.

The project page is at ppcboot.sourceforge.net .  It  contains  hints
how  to  access the anonymous CVS server at sourceforge where you can
find the latest and  greatest  versions  of  PPCBoot.  You  can  also
download the tarball of the "official" released versions from our FTP
server, see ftp://ftp.denx.de/pub/ppcboot .

For PPCBoot related questions you should  join  the  PPCBoot  mailing
list - see http://ppcboot.sourceforge.net/#mailinglist

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Engineering without management is art."               - Jeff Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
