To: "Jacky Lam" <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Queston about Walnut 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 17:17:00 +0800."
             <012801c388c5$f4378540$2803050a@JackyLam>
Date: Thu, 02 Oct 2003 12:13:10 +0200
Message-Id: <20031002101315.499C3C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <012801c388c5$f4378540$2803050a@JackyLam> you wrote:
>
>     I get a IBM 405 GP evaluation board recently. After I compile the
> toolchain and kernel 2.4.22 using the crosstools. I try to boot the kernel
> on the board by u-boot. I follow the instruction of uboot to create a uImage
> as follows:

Who gave you such (obviously wrong) instructions?

>     ## Booting image at 00400000 ...
>    Image Name:   test
>    Created:      2003-10-02   8:51:50 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    612743 Bytes = 598.4 kB
>    Load Address: 00400000
>    Entry Point:  00400000

For PowerPC systems, both  Load  Address  and  Entry  Point  must  be
specified as 0.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It may be that your whole purpose in life is simply  to  serve  as  a
warning to others.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
