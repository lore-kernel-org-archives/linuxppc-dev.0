To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: how to pass kernel command parameters? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Jan 2004 15:27:38 EST."
             <p06010202bc333bc03e48@[192.168.9.5]>
Date: Tue, 20 Jan 2004 21:38:31 +0100
Message-Id: <20040120203836.76E28C11FC@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <p06010202bc333bc03e48@[192.168.9.5]> you wrote:
>
> I have a Brightstar box with an MPC823, booting under 2.4.21 at the
> moment. But at the "Linux/PPC load:" line I have to enter a rather
> long string of parameters (IP numbers etc), I guess due to the boot
> ROM code that's part of this little Brightstar device.
>
> What is the proper way to automate the passing of these parameters?

Install U-Boot.

> I'm gathering that all ppc kernel boots have this line to stop at,
> but the passing of parameters to it is automated.

This depends a bit on the boot loader you are using, and/or the Linux
kernel wrapper used with it. If you are looking for  convenience  and
powerful  features,  check  out  what  U-Boot can do for you. See for
example http://www.denx.de/twiki/bin/view/DULG/LinuxBootArgs

> Should I be constructing a custom ram disk that contains the info? If
> so, what's a good resource about making ram disks and how to do this?

Documentation/ramdisk.txt in your Linux kernel tree?

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anything free is worth what you pay for it.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
