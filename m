Message-Id: <5.1.0.14.2.20020621164532.05f55b50@falcon.si.com>
Date: Fri, 21 Jun 2002 16:58:02 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Can I run linux without a file system?
In-Reply-To: <3.0.3.32.20020621143133.006d37a8@hollabaugh.com>
References: <5.1.0.14.2.20020621155315.05f3e830@falcon.si.com>
 <20020621194234.37274.qmail@web21103.mail.yahoo.com>
 <200206211835.g5LIZDL01282@hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK, you and John Kerl caught me fear-mongering :-).  Thank you for the link
and shameless plug, it looks very, very useful.  4.8MB is very respectable
but not what most people think about when they say "minimal file
system".  Tim wants less than 1MByte, care to take up THAT challenge
:-)?  That would require shrinking the libraries to just the necessary
functions, which is a big jump in difficulty.

gvb


At 02:31 PM 6/21/2002 -0600, Dr. Craig Hollabaugh wrote:
>At 04:12 PM 6/21/2002 -0400, Jerry Van Baren wrote:
> >
> >You need at least a RAM file system for "/" and a bunch of subdirectories
> >such as /dev, /lib, etc.  The common way to do this on a minimalistic
> >system is to create a file system image in ROM (often compressed) and copy
> >it to RAM on start up.  Given the questions you are asking, I am very
> >confident creating a minimal RAM disk image will challenge you sufficiently
> >:-).  I'm not being snide, lots of people with lots of linux knowledge have
> >tried and failed.  Most people use someone else's pre-configured minimal
> >file systems and add/subtract (mostly add :-) programs to it.  This is
> >because it is very, very hard to create a minimal file system (that works,
> >that is).
>
>I disagree. Creating a minimal root filesystem is easy once you understand
>what
>happens when init executes. (Shameless plug here) In my Embedded Linux
>book, I show
>you exactly the files needed to get bash running with a network
>connection. You use ldd to find out lib dependencies. Then copy binaries
>you want with their libs and some config files and your done. Here's my
>script to build such a root filesystem
>(http://www.embeddedlinuxinterfacing.com/chapters/04/buildrootfilesystem/buildrootfilesystem).
>Look it over, it probably won't make much sense without reading chapter 4.
>
>I can say that a minimum RedHat install uses 29,296 files ­ 382.020MB,
>debian 10,734 files - 67.428MB, my minimal root filesystem 82 files and 4.8MB.

[snip]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
