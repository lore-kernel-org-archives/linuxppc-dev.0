Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 13 Jun 2002 13:43:34 -0000
Message-ID: <20020613134334.24727.qmail@webmail21.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Lin,    Nan-Hung" <carl@fiberlogic.com>
Subject: Re: Re: ramdisk problem
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi Wolfgang ,
    yah i have stripped off ppcbootloader as u saud inthe mail ,
  i  have set cross compiler for ppc on my i386 machine ,
after compiling zImage i give command make zImage.initrd
so that r4,r5 contain initrd offset and size
i am getting initrd offset as 9099b

initrd_load routine is called ,he is checking at this loaction for
start of ramdisk image ,he is not getting it, so he says couldnt
find valid ramdisk image

what can be the problem
thanks in advance
regards
somshekar






On Thu, 13 Jun 2002 Wolfgang Denk wrote :
>In message <20020613111432.22212.qmail@webmail27.rediffmail.com>
>you wrote:
> >
> > when i am booting its saying ,couldnt find valid ramdisk image
>,i
> > am using pRamdisk from denx site which u have sent me the
>link
>
>As I wrote you have to strip the PPCBoot header if you are not
>using
>PPCBoot as boot loader.
>
>Did you do this?
>
> >    he is calling PAGE ALIGN
> >   i dont what it does  but i mostly think
> >     it computes the offset after after zImage
> >   as it is given as a parameter
>
>I cannot make sense out of this. What exactly did you do? How did
>you
>build your zImage.initrd image?
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded
>Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email:
>wd@denx.de
>It would seem that evil retreats when forcibly confronted
> 	-- Yarnek of Excalbia, "The Savage Curtain", stardate 5906.5


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
