Message-ID: <374D4C8C.7EE3C2A0@americasm01.nt.com>
Date: Thu, 27 May 1999 09:45:48 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and egcs developer releases
References: <m2d7zwrfxz.fsf@wf-rch.cirr.com> <99052001120800.00981@ns1102.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
> 
> Am Wed, 19 May 1999 schrieb Corey Minyard:
> >Is anyone tracking the egcs developer releases on LinuxPPC?  I'm
> >trying to build the newest developer release (19990517) and I have
> >tried to build earlier ones, but they all get a SEGV compiling
> >SYSCALLS.c with the stage1 compiler.  This is on linux 2.1.127 with
> >the egcs-1.02 prerelease compiler.
> 
> You need binutils >=2.9.1.0.23 or current cvs binutils to be able to build
> gcc-2.95 on ppc-linux. Probably the easiest way is to build the DRR1/preR5
> SRPM binutils-2.9.1.0.990418-1c.src.rpm available on ftp.linuxppc.org on your
> system.

I just tried to build egcs 990517 last night on my pre-R5 system
(installed last weekend) and I hit a snag.  In gcc/genattrtab.c, it
complains:

In function `max_attr_value':
4733: `INT_MAX' undeclared (first use this function)

I have /usr/include/linux pointing into a 2.2.6 tree.  I haven't tried
to track this down in depth, but I'm hoping someone knows offhand what
the problem is.  I suspect I have messed up system headers.  Any help
would be appreciated.  I don't think it's an egcs problem because it
builds fine on HPUX and other platforms.

I upgraded to pre-R5 from a mklinux DR3 distrib with a few more recent
updates.  As an aside, I hit a couple of nasty problems.  First, the rpm
with all the network tools didn't get updated because the DR3 rpm had a
larger number than the pre-R5 rpm.  The second (this cost me a couple of
hours to rescue) is that pre-R5 (or DR3?) had the bright idea of setting
my keyboard to `us'.  Problem is, this keymap is for a PC keyboard.  All
my keys were mapped all over the place.  After I figured out what was
going on, I had to determine where all the characters really were so I
could edit the config file to use `mac-ext-us' instead.  BEWARE!

Since there aren't tons of complaints about this, it may be an artifact
of upgrading a DR3 install.


-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
