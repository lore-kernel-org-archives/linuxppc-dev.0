To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: vmlinx and ppcboot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Jan 2003 16:05:42 PST."
             <3E1F5FD6.4080107@redswitch.com>
Date: Sat, 11 Jan 2003 01:19:00 +0100
Message-Id: <20030111001905.BA07DC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E1F5FD6.4080107@redswitch.com> you wrote:
>
> If I has ppcboot working and has a vmlinux.gz, do I need any other
> working boot code from the kernel tree? I mean, if my making a linux

No.

> kernel image 'make zImage' fails at the last step (building a zvmlinux),
> is the vmlinux.gz image built valid for ppcboot to boot the kernel?

No.

PPCBoot does not accept a vmlinux.gz image.  It  requieres  an  image
created by the mkimage tool. See the README that comes with PPCBoot.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Even if you aren't in doubt, consider the mental welfare of the  per-
son who has to maintain the code after you, and who will probably put
parens in the wrong place.          - Larry Wall in the perl man page

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
