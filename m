Date: Mon, 25 Sep 2000 14:26:17 -0400
Subject: ybin, nvsetenv and MacOS X
From: johnathan spectre <jspectre@lords.com>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5F51108.2280%jspectre@lords.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks to Ethan Benson's help I have ybin up and running, updating nvsetenv
(available at
ftp://www.penguinppc.org/users/hollis/pmac-utils-2.0-2.src.rpm) let me use
nvsetenv with a PowerBook G3 (Firewire). ybin will now properly set OF's
boot variables so I don't have to.

I now have one problem left. The triple-booter works fine for MacOS 9 and
Linuxppc (via yaboot), but when I try to boot MacOS X I have the following
problem...

After an install of ybin (I've reinstalled it a few times) selecting "x"
will result in some disk activity the first time I press "x". Then return me
to ybin's boot menu.

Pressing "x" every time after boots me into my MacOS 9 partition as if I
pressed "m" or let the system boot to default (it doesn't cycle after that
first time).

I'm wondering if ybin hasn't been updated to MacOS X Beta yet or is
something wrong? OS X is installed on partition 16 on my system and boots
fine if I use Apple's boot disk app to set it as the boot volume.

Additionally, I tried "boot hd:16,\\:tbxi" which is what I thought the boot
menu was trying to do. I get an error message and nothing happens (I might
be wrong though, I'm still learning what these scripts do).

Any help? Suggestions? Thanks!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
