To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Oct 2002 11:46:01 CDT."
             <Pine.LNX.4.33.0210141138290.24959-100000@localhost.localdomain>
Date: Mon, 14 Oct 2002 18:55:11 +0200
Message-Id: <20021014165516.B1EA7FAA5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.33.0210141138290.24959-100000@localhost.localdomain> you wrote:
>
> We are trying to wade our way through the various processor choices and
> options available for PPC on Linux.
>
> One of our requirements is to be able to run the same binary image across
> a range of systems. The image can not change just because the processor
> does.
>
> We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC III.

What do you mean with "image"?

Kernel Image? Application image (for example ramdisk  with  libraries
and application binaries)? Both combined?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have often regretted my speech, never my silence.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
