Date: Wed, 24 Oct 2001 12:11:42 -0400
Subject: Re: JDK 1.3
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: Stefan Pfetzing <dreamind@dreamind.de>,
	linuxppc-dev@lists.linuxppc.org
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
From: Daniel Berlin <dan@cgsoftware.com>
In-Reply-To: <706EA32A-C897-11D5-A979-0030654D6A26@ivey.uwo.ca>
Message-Id: <D0150CF8-C899-11D5-910E-0030657B5340@cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On the subject of JVM's, in case no one noticed, there is now an
optimizing one to play with.
IBM released the source to the Jikes RVM (Also known as the Jalapeno
project), which supports building/running on PPC Linux.  No JNI yet, but
IIRC, they are working on it.  It's also not meant to be a production
quality. But it's *something*.

Also note that in IBM's future java plans, it says:
"IBM plans for Java 2 SE technology encompass delivering IBM Developer
Kits for Java version 1.3.1 on an expanded range of platforms (AIX -
PowerPC 32-bit and PowerPC 64-bit; zOS; AS/400; Windows 32-bit and
64-bit; Linux on 32-bit and 64-bit Intel architecture, Linux on PowerPC
32-bit, Linux on 32-bit zSeries) with delivery currently scheduled for
4Q 2001 and 1Q 2002 depending on the platform. OS/2 is scheduled for
1H2002. Our implementation of version 1.3.1 will include enhancements to
the JIT compiler, garbage collection technology and JVM serviceability."
Having worked for IBM research over the summer, let me just say that
working with a JDK with a JIT on PPC Linux was quite nice, after having
to use one with no JIT for so long.

On Wednesday, October 24, 2001, at 11:54  AM, Kevin Hendricks wrote:

>
> Hi,
>
> What symbol does it complain about?
>
> Mozilla has changed it plugin interface slightly in 0.93, 0.94, and 0.95
> which is making for a real pain.  I asked the x86 Blackdown guys and
> they are build jdk 1.3.1 against mozilla 0.91 and that plugin seems to
> work with everything to date.  The issues come in when later mozilla
> headers are used to build the plugin.
>
> I will retry building the plugin against mozilla 0.91 and post it in the
> form of the jre for people to try.
>
> Kevin
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
