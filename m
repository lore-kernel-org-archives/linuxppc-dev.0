To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot, linux , hang at the last step 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Nov 2002 14:08:26 +0530."
             <3DE33302.4070907@tataelxsi.co.in>
Date: Tue, 26 Nov 2002 11:00:49 +0100
Message-Id: <20021126100054.4530FC614B@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3DE33302.4070907@tataelxsi.co.in> you wrote:
>
> No. The kernel does not have a built in ramdisk. but it uses the ramdisk
> image passed for modules and the like. correct me if I am wrong.

Please do not confuse the usage of  a  ramdisk  image  with  standard
distributions  like RedHat etc. With Embedded Systems a ramdisk image
usually severs a bit a different purpose.

>  > or you have to give a ramdisk separately to the kernel boot args?
> initrd='ramdisk image' is the option I gave.

This may be correct with some boot loader like LILO, bot it i s not a
valid kernel boot argument.

>  > the option is " root=/dev/ram ",  right?
> Frankly, I am not sure. someone else might be able to help you.

Yes, "root=/dev/ram" (or usually "root=/dev/ram rw") is  the  correct
kernel boot argument for booting with an initial ramdisk image.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The computer programmer is a creator of universes for which he alone
is responsible. Universes of virtually unlimited  complexity  can  be
created  in  the  form  of  computer  programs." - Joseph Weizenbaum,
_Computer Power and Human Reason_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
