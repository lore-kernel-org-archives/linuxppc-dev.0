To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Lin,     Nan-Hung" <carl@fiberlogic.com>
Subject: Re: ramdisk problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "13 Jun 2002 13:43:34 -0000."
             <20020613134334.24727.qmail@webmail21.rediffmail.com>
Date: Thu, 13 Jun 2002 15:54:40 +0200
Message-Id: <20020613135445.2C07E102F8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020613134334.24727.qmail@webmail21.rediffmail.com> you wrote:
>
> after compiling zImage i give command make zImage.initrd
> so that r4,r5 contain initrd offset and size
> i am getting initrd offset as 9099b
>
> initrd_load routine is called ,he is checking at this loaction for
> start of ramdisk image ,he is not getting it, so he says couldnt
> find valid ramdisk image
>
> what can be the problem

How do you load the image? Linux uses a special segment  in  the  ELF
file  for the initrd image; maybe your bot loader does not understand
this, and drops it?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Have you lived in this village all your life?"        "No, not yet."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
