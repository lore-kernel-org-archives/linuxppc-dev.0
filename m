To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory Pre-allocation (mem=xxx) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Feb 2002 16:42:46 PST."
             <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com>
Date: Sat, 23 Feb 2002 01:57:24 +0100
Message-Id: <20020223005729.F26B1109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8A098FDFC6EED94B872CA2033711F86F0ABD0C@orion.ariodata.com> you wrote:
>
> We're working on a project that requires a two megabytes block of
> contiguous memory in kernel space. Although it is well documented that
> memory can be reserved by using mem=xx arguments during boot time, it is
> unclear (to me) as to how a driver can automatically detect the size of
> the said reserved block.

Pass an extra boot argument?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Generally speaking, there are other ways to accomplish whatever it is
that you think you need ...                               - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
