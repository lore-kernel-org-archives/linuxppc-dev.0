Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001c01c3bb0a$e18eb900$0400a8c0@eurostudio.local>
From: "AlessandroPPC" <aleppcrossi@libero.it>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20031203181613.75859C5F5F@atlas.denx.de>
Subject: R: ram root filesystem 
Date: Fri, 5 Dec 2003 09:36:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Many Thanks Wolfgang Denk for your indacations.
Something abaut your questions.

> Question 1: why don't you use the  much  simpler  and  smaller  setup
> based  on  the  SELF  ramdisk  example  image included with the ELDK?
> Please see http://www.denx.de/twiki/bin/view/DULG/HowToAddFiles

My application now is running and it is stable with nfs-ELDK package, and I
want pass
to ram fs to do a more efficiently embedded system with the minimum
difference respect
 to nfs because I don't want to lose the stability.

> Question 2: Why don't you simply use the genext2fs  tool  that  comes
> included  with  the  ELDK?  It  is much simpler, and requires no root
> permissions to create a ramdisk image.
>

Yes I will try the genext2fs  tool .

> The "rc.sysint" was never meant to be used from a ramdisk based  root
> filesystem.  If  you  change  your configuration, you are expected to
> adapt all related config files and init scripts, too.

Ok I 'm just adapting my config files and init scripts.


>
> It makes no sense to run fsck on  a  ramdisk  image  which  was  just
> unpacked.  Also,  IMHO  it  makes littlee sense to use the full-blown
> SysV init style scripts in an embedded system which is running from a
> ramdisk image.
>
Yes I agree, but the question is : why a tool thought to check fs don't work
on my fs image? Where is the mistake?
Sorry, but what do yo mean with IMHO ?

> Have a look at the ELF image thatis included with the ELDK,  and  use
> this as a base.
>
I'm investigating abaut your ELF image...

Thanks again,
Regards,
Alessandro


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
