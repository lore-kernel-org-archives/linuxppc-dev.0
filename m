Message-ID: <393D0D62.8D0979E2@relog.ch>
Date: Tue, 06 Jun 2000 16:40:34 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Sinan Gürkan <sgurkan@superonline.com>
CC: linux-apus-user@lists.sourceforge.net, linux-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New experimental X 4.0 not working
References: <yam8192.1708.1987516072@mail.superonline.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I'm forwarding this to the MLs so everyone knows]

Sinan Gürkan wrote:

> I installed XFree4.0b...but it doesn`t work...
> after startx command it loads a bit and it freezes the whole system.
> You have to reboot and filesystem is corrupted..(I ran fsck 3 times :) )

Do you use update/bdflush/whatever? I get lotsa lockups when hacking kernels
and X servers, but I've never had to run fsck more than twice (once
automatically and once manually).


> I am sending you the XFree86 log
>
> XFree86 Version 4.0a / X Window System
                  ^^^^
You are using the 4.0a loader with 4.0b modules. Use the 4.0b loader.


Michel


--
Failure is not an option. It comes bundled with your Microsoft product.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
