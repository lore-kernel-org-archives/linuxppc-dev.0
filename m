Mime-Version: 1.0
Message-Id: <v04210118b436c5fee245@[192.168.0.1]>
In-Reply-To: <Pine.LNX.4.10.9910221844130.25175-100000@shell.unixbox.com>
References: <Pine.LNX.4.10.9910221844130.25175-100000@shell.unixbox.com>
Date: Fri, 22 Oct 1999 18:03:33 -0800
To: Ani Joshi <ajoshi@shell.unixbox.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Cc: Peter Bierman <bierman@apple.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22/10/99 Ani Joshi wrote:

>
>	could you please get yourself a "clue" and stop making such stupid
>statements, this will prevent people from thinking you are as foolish as
>your statements.

excuse me?  OSX will not change the current OF that we have now which 
is preventing a non macos bootstrap, OSX bootloader is not going to 
load linux we still have to hack our own.  after OSX comes around 
Apple's OF will likely stop being so bloody macos 8* specific. as I 
believe is what peter meant. that does not change a damned thing for 
all the broken machines we have now.

>
>	2.4?  if its 2.3 you mean, hfs works fine with the latest (2.3.22
>on my box is doing hfs fine), and i recall long ago formatting an hfs
>floppy, though i forgot the util, i think it was in hfs-utils or
>something....  i may be wrong though...

I recall a thread on this list not too long ago where it was reported 
that HFS.o needed to be modified or rewritten to be compatible with 
the new kernel, just like every other filesystem, it was mentioned as 
a concern because nobody seems to be maintaining the hfs filesystem 
code. (or netatalk or anything else in the apple filesystem realm)

>
><flame>
>	personally, this sounds like a lot of whining, this really has no
>place here.  if you could please add some constructive comments on what
>needs to be done instead of "this sucks, of sucks, you morons morons need
>to fix it", why don't *you* do something about it then?  why don't you try
>and fix it?

bullshit, the current and past OF implemenatations have been causing 
nothing but trouble for just about everything related to linux, the 
more recent ones solve some problems but created new ones for the 
bootstrap, Peter seems to agree with me that OF is broken in its boot 
method as it creates headaches for OSX as well!  I have been spending 
alot of time trying to find various way to get OF to work with 
anything non macos and its really quite a pain.  I HAVE been trying 
to do some things to fix it, I have given Ben alot of clues and 
information to help with this issue.   so why don't you stop your 
useless flaming.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
