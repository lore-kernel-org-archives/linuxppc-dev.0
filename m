Message-ID: <3716103B.E1F6D4C4@email.com>
Date: Thu, 15 Apr 1999 12:13:48 -0400
From: Luke Andrews-Hakken <landrews@email.com>
Reply-To: landrews@email.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Booting IDE B&W G3. (it's easy!)
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay this is the third time I have tried sending this message. I don't
know what the problem is but if you get multiple copies I'm sorry.

It is most definately possible to boot linuxppc with the new kernal on a
B&W. I know I'm sitting here right now in X and I'm happy to be back.
Okay here's the deal:

first off. You Must have a second IDE Hard Drive. I'm useing an old 2GB
from a motorola Starmax. (i don't know the model, it just has an OEM
sticker on it). The hard drive is sitting in the Zip slot with the
pre-installed apple IDE cable running into it.

2) Use the kernal linked from www.linuxppc.org/news/BlueG3.shtml

3) You'll need bootX of course. And the ram disk. And the utils.sit that
are listed in the imac install. MAKE SURE YOU FTP THESE IN BINARY
FORMAT. Also place the folder in / on your mac partition. (I.E. not on
the desktop).

4) Rename the vmlinux-2.2.1-challenger2.gz to just vmlinux and place it
in the same directory as BootX. Fire it up with the "no video driver"
and "use ramdisk" buttons checked. This should dump you into the redhat
installer.

5)From there on it's gravy. use pdisk to partition. check the packages
you want. Etc. The installer runs get the packages and bingo. Your
golden

NOTE: Near the end of the installer it asks you to install the boot
?blockers? I skipped this because it didn't seem right. Anyway if anyone
has any idea if this is good or bad tell me.

Also I haven't moved the bootX foler, or any componets from there
original place. I also have to specify the partition number in the bootx
window.
                          /dev/hdb6 <-- for example.

Well that's it good luck guys (and girls) any further questions please
email me

_luke
http://raptor.slc.edu/~apex/

( yes I was the guy who compiled linuxppc quake. Don't ask me about that
right now. It's very painful when a server goes down taking all of your
data with it).




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
