Date: Thu, 2 Sep 1999 13:02:02 -0400 (EDT)
From: Gabe Ricard <gabe@admin.arhs.net>
To: linuxppc-user@lists.linuxppc.org
cc: linuxppc-workstation@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Really Slow Video
Message-ID: <Pine.LNX.4.10.9909021255350.22779-100000@admin.arps.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got a UMAX S900DP Dual 250MHz system with an IMS Twin Turbo 8MB video
card. I installed LinuxPPC on it some time ago and I've been getting
really annoyed at how slow the video performance is in X. I've done a
little investigation and it turns out that it's using some kind of OF
frame buffer support for the card. Is there no direct support for this
card in the kernels? Is this what is causing X to be so slow? I also
noticed that it won't let me run in any mode other than 32bpp, which for
me is totally unnecessary and unneeded. My monitor is an older SuperMac
19" fixed rate monitor (1152 x 875 or something).

Anyway I can make X Windows faster?

--
Gabe Ricard
gabe@admin.arps.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
