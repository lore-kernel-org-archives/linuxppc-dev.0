Message-ID: <3E540547.5090103@mvista.com>
Date: Wed, 19 Feb 2003 16:29:27 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerMac vs. Intel for PowerPC Development Host
References: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
In-Reply-To: <995FF289C9D69747A09E42992644595405B23678@penguin.adic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


brian.auld@adic.com wrote:
> A while back I wrote an email to this list regarding development kit
> suggestions. Based mainly on feedback from this email, I am currently moving
> in the Intel/ELDK direction.
>
> Out of all the feedback I received, only one person suggested developing on
> a PowerMac based Linux box, thus eliminating the need for cross-compiling. I
> have become more interested in this option as some people in our company
> have noted that cross-compiling embedded linux presented problems on past
> projects when it came to building certain 3rd party applications.

I say regardless of the host architecture you want to cross compile unless your
host architecture IS the same as your target architecture.  (Yes you can
"cross-compile" from powerpc to powerpc or ia32 to ia32.)

Our product is setup for cross compiling and/or "native" compiling.. but we do
not support a customer building on their "host" OS and just copying the
resulting binary over and running it.. library and compiler incompatabilities
are the at the top of the "reasons not to do that" list.

> In the Intel vs. Mac debate for a linux development host for embedded ppc
> development, if money was not an issue, would I get more PowerMac
> recommendations??

I have both a Mac and PC on my desk.  I use whichever is better at doing what I
want at the moment.  If you are picking a pre-built development environment you
will have limits as to your host architecture (host OS)..  If you are building
your own just pick whatever you feel more comfortable with.

(FYI I routinely use Solaris 8, x86 (Dual Athlon) w/ RH 7.3 and a Titanium
PowerBook w/ YDL on it for development.. and due to the cross compiling I just
migrate my target from machine to machine via NFS and can do whatever I need to.)

The "host" architecture and OS should really not be a factor in your embedded
development decision..  as far as I'm concerned all hosts are equally broken.. :)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
