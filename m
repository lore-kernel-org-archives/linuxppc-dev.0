Date: Wed, 26 Nov 2003 10:52:18 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross Compiler running under Win32
In-Reply-To: <3FC4B0EC.3090107@imc-berlin.de>
Message-ID: <Pine.LNX.4.44.0311261019570.17218-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Green Hills Software has its own compiler which we can host from Windows,
Linux, Solaris and HPUX. At the moment we still make use of the GNU linker
though, so to use our stuff you still need binutils working on your host.
Apparently the compiler group is considering supporting Linux targets with
our linker, I have no idea what the status of that is though.

Any particular reason why you don't want to use Cygwin?

	nathan

PS. I don't know if this list allows plugging non-GNU software, if it
doesn't please ignore this bit. Our compiler produces significantly
smaller and faster code that pretty much anyone else. An internal test
showed code size differences when compiling the Linux kernel at 20+%
smaller than GNU gcc 3.x and well over 30% against 2.95. We didn't do much
benchmarking, but the speed difference was apparently big enough that it
was visable during kernel boot. I believe the kernel cross compile was
entirely with our tools.

On Wed, 26 Nov 2003, Steven Scholz wrote:
>
> does someone know of a cross compiler (producing code for let's say
> MPC8xx) that is running natively under win32 (Windows2000/XP) without
> stuff like CYGWIN?
>
> I'am just wondering. Apparently MVISTA released their new "DevRocket"
> which is supposed to run under WindowsXP. So I assume they have cross
> compilers for "30 processors from 8 architectures" running under
> Windows...

--
Nathan Field (ndf@ghs.com)			            In my pocket.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
