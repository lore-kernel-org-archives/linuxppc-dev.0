Message-Id: <200008162354.BAA31708@denx.local.net>
To: Pravin Pathak <pkpathak@dnrc.bell-labs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is embedded linux ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Aug 2000 18:03:57 EDT."
             <399B0FCD.A6E0A6BE@dnrc.bell-labs.com>
Date: Thu, 17 Aug 2000 01:54:45 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Pravin,

in message <399B0FCD.A6E0A6BE@dnrc.bell-labs.com> you wrote:
>
> I have a silly question. How does embedded linux works without disk
> support ?

There are many ways: loading over ethernet, from flash, ...

> I mean from where it loads shell and other application task images
> without any file system

What makes you think there is no filesystem support?

> support ? For VxWOrks/pSOS have a single object file. How about Embedded
> Linux ?
> I am confused on this matter. Or it always need some kind of file
> support like NFS to boot ?

Usually you will always want to have some filesystem support. Unix is
pretty much build around the idea  of  mounting  some  type  of  root
device  -  so  you  will  usually  always find a root directory, most
probably also a /dev/ directory in it, etc.

There are many ways  to  build  such  a  system.  a  NFS  based  root
filesystem  is one; another is uising a ramdisk image which is loaded
with the kernel from some boot device (flash, network, ...).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Given a choice between two theories, take the one which is funnier.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
