Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 13 Jun 2002 15:20:00 -0000
Message-ID: <20020613152000.18777.qmail@webmail22.rediffmail.com>
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


hi Denk,

      i use kernel provided bootloader to load image,
  i am using binary form of zImage
  i didnt get u denk ,i dont know abt this elf what u have said ,i
am not sure abt it ,i will check it
















On Thu, 13 Jun 2002 Wolfgang Denk wrote :
>In message <20020613134334.24727.qmail@webmail21.rediffmail.com>
>you wrote:
> >
> > after compiling zImage i give command make zImage.initrd
> > so that r4,r5 contain initrd offset and size
> > i am getting initrd offset as 9099b
> >
> > initrd_load routine is called ,he is checking at this loaction
>for
> > start of ramdisk image ,he is not getting it, so he says
>couldnt
> > find valid ramdisk image
> >
> > what can be the problem
>
>How do you load the image? Linux uses a special segment  in  the
>ELF
>file  for the initrd image; maybe your bot loader does not
>understand
>this, and drops it?
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded
>Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email:
>wd@denx.de
>"Have you lived in this village all your life?"        "No, not
>yet."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
