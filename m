From: duncanp@research.canon.com.au
Date: Tue, 22 Feb 2000 10:09:49 +1100 (EST)
Subject: Re: Bootloader with debug monitor functions.
To: Ilya Gindentuller <igin@vrcomm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000b01bf7c93$7477aca0$65daa8c0@pcclub04>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000221230952.0C8F77AB@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Ilya,

Sounds like you are doing something very similar to me. I've started
work on a bootloader which is aimed at some MPC855T based hardware we're
building, and also the embedded planet RPX classic boards. I've been
using the 8xxrom source as a basis for this
(http://www.s4l.de/powerpc.html). 8xxrom is based on the fadsrom
code which is on the linuxppc-embedded ftp server. I won't have any
code available for a while, but will be happy to share when I do.

Dunk.

On 21 Feb, Ilya Gindentuller wrote:
>
> Hi, everybody!
>
> We are new to Linux development, so all help is greatly appreciated !
>
> We have our new target board based on MPC860T almost ready and now we are
> trying to
> cross-compile and build Linux kernel 2.2.13 using x86 PC.
>
> The problem is that we do not have any bootloader and/or debug monitor to
> boot Linux
> image - only BDM debugger.
>
> If somebody could  give us his bootloader/monitor source code so that we
> could build it,
> that would really help.
>
> Thanks in advance,
>
> Ilya Gindentuller
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
