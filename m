Message-ID: <20020621202855.29752.qmail@web21104.mail.yahoo.com>
Date: Fri, 21 Jun 2002 13:28:55 -0700 (PDT)
From: Tim Lai <laitingwai@yahoo.com>
Subject: Re: Can I run linux without a file system?
To: Jerry Van Baren <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20020621155315.05f3e830@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all the replies. After reading all the
helpful response. I think I will try to use initrd,
and probably try ramdisk, too. I don't necessary need
to run with a minimum system. The hardware has 8M,
and I will try 1M for ramdisk. It seems like this
is the easiest way to get thing starts.


--- Jerry Van Baren <vanbaren_gerald@si.com> wrote:
>
> You need at least a RAM file system for "/" and a
> bunch of subdirectories
> such as /dev, /lib, etc.  The common way to do this
> on a minimalistic
> system is to create a file system image in ROM
> (often compressed) and copy
> it to RAM on start up.  Given the questions you are
> asking, I am very
> confident creating a minimal RAM disk image will
> challenge you sufficiently
> :-).  I'm not being snide, lots of people with lots
> of linux knowledge have
> tried and failed.  Most people use someone else's
> pre-configured minimal
> file systems and add/subtract (mostly add :-)
> programs to it.  This is
> because it is very, very hard to create a minimal
> file system (that works,
> that is).
>
> Pointers to development systems with example RAM
> disk images:
>    http://www.denx.de/solutions-en.html
>      ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/
>    http://www.mvista.com/
>    (there are others, I'm just too lazy to do the
> google search for you)
>
> Trying to run linux without a file system of any
> sort would require you to
> rewrite of pretty much everything and the three or
> four things you didn't
> rewrite, you would have to rebuild (static link, no
> shared
> libraries).  There are a lot of software engineers
> and hackers that would
> turn down the opportunity to do this at any price.
> On the other hand, a
> lot of naivety and a even more coffee sometimes
> generates remarkable
> results :-).
>
> You really want to look at eCOS or one of the other
> light weight tasking OSs.
>    http://www.redhat.com/embedded/technologies/ecos/
>
> gvb
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
