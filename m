Mime-Version: 1.0
Message-Id: <v04210112b436ae4d5107@[192.168.0.1]>
In-Reply-To: <v0313030db436a6abe40d@[17.202.21.235]>
References: <3810680B.51E0FABD@iname.com> <3810680B.51E0FABD@iname.com>
 <v0313030db436a6abe40d@[17.202.21.235]>
Date: Fri, 22 Oct 1999 16:24:01 -0800
To: Peter Bierman <bierman@apple.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22/10/99 Peter Bierman wrote:

>
>Heheh. How true.
>
>OF serves no one's goals beyond booting Mac OS.

right MacOS8.* EXCLUDING OSX

>Anything else is good
>fortune for those using it. The good news is that as new machines come out,
>OF generally gets better at booting non-Traditional Mac OS things.
>
>Mac OS X should make your lives easier.

not really. unless we buy new hardware of course (assuming OF 
engineers get some clue at some point.)

>I suggest a small HFS springboard partition. OF on all machines knows how
>to find and boot an HFS volume. You can put a fake System folder with a
>boot 2 resource, and a tbxi fake ROM image that acts as your booter.

thats unnecessary, OF could not give a flying fart about a system 
folder, blessed folders etc, you can point it directly at a ordinary 
file.

using HFS is not an option IMO because it must be created on macos, 
unless someone wants to write a mkfs.hfs, didn't think so.  no thanks 
I'll stick with a DOS partition that I can take care of in a total 
Free environment rather then keeping macos around just to maintain 
the bootloader.  (which is just as bad as using Bootx

>Standard HFS is a pretty simple filesystem.

not really, otherwise we would have mkfs.hfs and a 2.4 kernel 
compatible hfs.o, its obviously complicated enough that nobody wants 
to spend the time on it. (more to the point its irrelevant how 
complicated it is, nobody is working on it.)

>if you go with the above design, I predict you'll have a lot less work to
>do to keep up with new hardware and OF versions.

using DOS partition tables and a DOS partition in place of non free 
HFS has no problems either, we still need a second stage quik that 
does something useful however.  (ISO filesystem might work too but I 
have had problems getting BF to read from it.)

>I don't work on OF, so don't bother asking,

can you sneak up on the OF engineers and give them a good healthy 
whack with a clue stick?



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
