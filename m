In-Reply-To: <v04210118b436c5fee245@[192.168.0.1]>
Date: Sat, 23 Oct 1999 13:26:04 +0200
To: Ethan Benson <erbenson@alaska.net>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: bypassing MacOS using Open Firmware on Apple pmac G3
Message-Id: <19991023132604.003036@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 22, 1999, Ethan Benson <erbenson@alaska.net> wrote:

>excuse me?  OSX will not change the current OF that we have now which 
>is preventing a non macos bootstrap, OSX bootloader is not going to 
>load linux we still have to hack our own.  after OSX comes around 
>Apple's OF will likely stop being so bloody macos 8* specific. as I 
>believe is what peter meant. that does not change a damned thing for 
>all the broken machines we have now.

OS X comes with OF patches that improve greatly OF behavious on almost
all PCI macs. Those patches are under the Apple open source licence (I
think so but Peter can confirm, I don't have them with me now). And for
those machines for which we don't really care about OF (we don't really
need the OF phandle's on them and we don't have RTAS), then a BootX-like
solution is fine and easier to install and that's why I wrote miBoot. I
don't think creating an HFS filesystem is so complex, and we might simply
at first bundle a pre-formatted small image (large enough for miBoot and
new OF secondary loader). There is still the issue of miBoot requiring
the kernel to be on the HFS boot partition, I agree.

>I recall a thread on this list not too long ago where it was reported 
>that HFS.o needed to be modified or rewritten to be compatible with 
>the new kernel, just like every other filesystem, it was mentioned as 
>a concern because nobody seems to be maintaining the hfs filesystem 
>code. (or netatalk or anything else in the apple filesystem realm)

We still have the hfsutils if Adrian don't find time to fix in-kernel
HFS. With those we can still write an installer.

>bullshit, the current and past OF implemenatations have been causing 
>nothing but trouble for just about everything related to linux

Related to booting, perhaps. But not related to linux. The presence of
the device tree has been quite useful but Paul is in a better position to
comment on this.

>the more recent ones solve some problems but created new ones for the 
>bootstrap, Peter seems to agree with me that OF is broken in its boot 
>method as it creates headaches for OSX as well!  I have been spending 
>alot of time trying to find various way to get OF to work with 
>anything non macos and its really quite a pain.  I HAVE been trying 
>to do some things to fix it, I have given Ben alot of clues and 
>information to help with this issue.   so why don't you stop your 
>useless flaming.

I think we should simply stop this discussion until someone comes up with
real code. Once I have the iBook working enough, I'll resume my various
booter experiments, my goal is first to make bootable CDs for distros,
and then to make a decent Linux OF booter (eventually graphical) for new
OFs. Apple's new built-in boot chooser is fun but too limited for linux ;)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
