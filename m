To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"Lin,     Nan-Hung" <carl@fiberlogic.com>
Subject: Re: ramdisk problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "13 Jun 2002 11:14:32 -0000."
             <20020613111432.22212.qmail@webmail27.rediffmail.com>
Date: Thu, 13 Jun 2002 13:49:38 +0200
Message-Id: <20020613114943.A4936102F8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020613111432.22212.qmail@webmail27.rediffmail.com> you wrote:
>
> when i am booting its saying ,couldnt find valid ramdisk image ,i
> am using pRamdisk from denx site which u have sent me the link

As I wrote you have to strip the PPCBoot header if you are not  using
PPCBoot as boot loader.

Did you do this?

>    he is calling PAGE ALIGN
>   i dont what it does  but i mostly think
>     it computes the offset after after zImage
>   as it is given as a parameter

I cannot make sense out of this. What exactly did you do? How did you
build your zImage.initrd image?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It would seem that evil retreats when forcibly confronted
	-- Yarnek of Excalbia, "The Savage Curtain", stardate 5906.5

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
