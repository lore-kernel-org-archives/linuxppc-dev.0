Message-ID: <3E97AA29.E44CBAD8@innomedia.soft.net>
Date: Sat, 12 Apr 2003 11:24:49 +0530
From: Anand Franklin J <franklin@innomedia.soft.net>
MIME-Version: 1.0
To: Craig Hollabaugh <craig@hollabaugh.com>,
	Linux Monta Vista <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel panic: No init found!!!!
References: <3E96E4B6.582DA2F9@innomedia.soft.net> <1050076574.463.2.camel@gibson>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Craig
I do have the /sbin/init file in my harddisk. what i performed is manally i
partitioned the harddisk into 3 , runned mkfs.ext2 then tune2fs on the
/dev/hda1 partition. copied all utilties from ppc directory(target) like
etc,bin,sbin... into /dev/hda1. configured the kernel to mount from harddisk.
still i don't know what is the problem.
thanking you.
franklin.
Craig Hollabaugh wrote:

> On Fri, 2003-04-11 at 09:52, Anand Franklin J wrote:
> >
> > hello All,
> >     I as using the Redwood 6 IBM PPC board. The Kernel gives the panic
> > when it boots (Kernel panic: No init found). can anybody say what is the
> > way to get rid off it.
> > thanking you,
>
> Do you have a /sbin/init file?
>
> --
> ___________________________________________________________
> Dr. Craig Hollabaugh                   craig@hollabaugh.com
> Author of Embedded Linux
>
> P.O. Box 1405
> Ouray, CO 81427-1405        See my "kitchen sink" resume at
> 970 325 4810 home            www.hollabaugh.com/resume.html
> 970 325 0509 office


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
