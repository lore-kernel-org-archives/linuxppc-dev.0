Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@lists.linuxppc.org
From: Costantino Pistagna <cpistagna@vrlteam.org>
Subject: ibook G4 Status Report
Date: Mon, 9 Feb 2004 18:48:22 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

i'm currently using an ibook G4 with Radeon9200 OnBoard.

Some months ago, i've wrote in this list asking about the status of the
driver
for both Xfree and framebuffer. Actually i'm using the system with
framebuffer
and Xfree, running a 2.6.1-ben1 kernel, but no support for dualhead
and/or
multiple screens.

Since my ibook is a 12" equipped, i really need to use the video output
with my 17" LCD.

Any clues ? and/or usefull start point ?. i've tried to look inside
xfree drivers sources,
but without any good results. Seems that radeon9200 does not provide,
any type of
multiple screen support.

A minor request is about the status of Broadcom BCM94306 driver. Looking
around i've noticed that many new Centrino-Based laptop are equipped
with
this wificard. After some minutes of googling i've reached a sf.net
hosted project
about a .vxd/Windows drivers wrapper; it successfully use the windows
drivers
for the above card under x86/linux. is there any way to use this method
under
linuxppc ?. Another time: any clues? and/or usefull start point ?

cheers,
--
[ Costantino Pistagna (PhD) :: unict :: dmi ]
[ s0ftpj ::: Vrl Team ::: freaKnet MediaLab ]
[ gpg key on pgp.mit.edu :: keyid  1d67b4dd ]


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
