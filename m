Subject: Re: cross compiling a complex project
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: John Que <qwejohn@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <BAY14-F15dPULDvYqNC0000a732@hotmail.com>
References: <BAY14-F15dPULDvYqNC0000a732@hotmail.com>
Content-Type: text/plain
Message-Id: <1083581925.4776.15.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 03 May 2004 12:58:45 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-05-03 at 10:59, John Que wrote:
> Hello,
> I had build a cross compiler for embedded linux which runs on embedded
> powerPC.
>
> It works ok on simple sample programs I wrote, like
> "hello world", etc, which do not use other libs.
>
> Now I want to use it to build some more complex projects (the complexity is
> relative
> to the samples I wrote, of course).
> I mean projects which have autocinf configure scripts.
> Like , for example ,  speex audio codec , or Midnight Commander.

I've had good experiences using Gentoo on the target with nfsroot.
Unpack a stage3 onto the nfs server, throw in a good amount of
Linux/Gentoo knowledge and your're going.

You'll need plenty of time, depending on the CPU performance,
glibc takes ~1 workday on a ppc603e@300MHz, but on the other hand this
makes an excellent stability test for your platform ;)
BTW: Lots of RAM required so you don't have to swap over the network.
It's also a good idea to have /tmp and /var/tmp as tmpfs.

The basic idea is that I find it easier to have a native
setup which may be relatively slow, but where I don't stumble
on every other package that does some platform-detection in
configure and forces me to fiddle with it.

There are brave projects like ptxdist and rock linux that do this
for you, but chances are that the package you're interested
in is just not there yet. But natively, it's just an "emerge" away.

Another idea would be of course to get a bigger brother, say
a dual G5 for building...

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
