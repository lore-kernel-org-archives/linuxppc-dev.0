To: "sun-zj" <sun-zj@tdk-tech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel can't boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Dec 2003 08:50:01 +0800."
             <200312260052.SAA27783@lists.linuxppc.org>
Date: Fri, 26 Dec 2003 11:25:41 +0100
Message-Id: <20031226102547.09126C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200312260052.SAA27783@lists.linuxppc.org> you wrote:
>
> I am using the ELDL-2.1 from denx(Thanks their hard works)
> and the recent kernel advised by Denk(thanks a lots). I compile
> it and download it by tftp with FEC ethernet.
> I use the FADS board and U-boot-1.0.0. The eldk enclosed
> kernel-2.4.4 works fine. But kernel-2.4.23 can go to the stage
> of Uncompressed kernel image OK. and then system Hangs there
> without any messages?

Probably the kernel received invalid parameters (clock information).

> Who can tell me what happens ?

You did not read the FAQ. See
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ernest asks Frank how long he has been working for the company.
        "Ever since they threatened to fire me."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
