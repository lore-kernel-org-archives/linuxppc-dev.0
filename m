Message-ID: <368CDBC4.366C@post.uni-bielefeld.de>
Date: Fri, 01 Jan 1999 15:29:25 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: BUG: 2.2.0-pre2 on 5500 (and maybe 6500)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

This bugreport applies to a PMac 5500/225, and maybe a 6500, because
they share a common motherboard.
I'm booting 2.2.0-pre2 kernel with BootX.

ftp://ftp.linuxppc.org/linuxppc/linuxppc-pre-R5/RedHat.installer/vmlinux-2.2.0-pre2

No-video problem:
First I'm booting with the "no video" box checked. I get a much too dark
picture, I can only see a few shades from the logo. I can't see the
login prompt. The last kernel I checked (2.1.127) didn't have this
problem.
Possible bug: palette not initialised.
Then I tried without the "no video" box. Now I get no video at all. This
is a problem I have since the first Kernel I've seen (2.1.24). Is there
a problem with my video-chip ? I've got an ATI chip, ATY264GT-B.

Audio problem:
You'll see in the kernel messages that there is an error during the
initialisation of AWACS. Now audio seems to be limited to 8kHz/mono.
BTW: Where has this "woop" sound gone to ? I prefer it much over a
simple beep...

I'll try test-kernels, but please reduce them of all options (network,
filesystem) that are not needed to test video/audio.

I've got the usual dmesg and a dump of the OF-tree. Anybody interested
in seeing this ? It's around 3k.

Jens

P.S.: Patch ? I'd like to, but I have not much information about the
hardware. What about starting a project to document all devices in a Mac
?
P.P.S: BootX vs. OF: I'm normally booting with OF, but to test kernels
I'm using BootX. It's a very nice program...


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
