From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and egcs developer releases
Date: Thu, 20 May 1999 01:06:47 +0200
Content-Type: text/plain
References: <m2d7zwrfxz.fsf@wf-rch.cirr.com>
MIME-Version: 1.0
Message-Id: <99052001120800.00981@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Wed, 19 May 1999 schrieb Corey Minyard:
>Is anyone tracking the egcs developer releases on LinuxPPC?  I'm
>trying to build the newest developer release (19990517) and I have
>tried to build earlier ones, but they all get a SEGV compiling
>SYSCALLS.c with the stage1 compiler.  This is on linux 2.1.127 with
>the egcs-1.02 prerelease compiler.

You need binutils >=2.9.1.0.23 or current cvs binutils to be able to build
gcc-2.95 on ppc-linux. Probably the easiest way is to build the DRR1/preR5
SRPM binutils-2.9.1.0.990418-1c.src.rpm available on ftp.linuxppc.org on your
system.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
