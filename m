Message-Id: <v03110700b7e554401d16@[64.230.146.224]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 6 Oct 2001 20:42:28 -0400
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: no luck with ATI Radeon 32 PCI and FlatPanel
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

The flatpanel works fine under MacOS9 but it will not even show the ybin
prompt which makes it hard to boot into linux  ;-)

Using the display registry on the MacOS side, the Radeon does in fact
provide all the the nice info we need:

ATY, RADEONp

ATY, RefCLK = 27000
ATY,MCLK = 166000
ATY,SCLK= 166000
width 1280
height 1024

RF_VCLK=10800
RF_MCLK=16615
RF_YCLK=33230
RF_SCLK=16615

Any ideas on how to boot this thing if the ybin prompt never even appears
on the screen (I tried blindly typing but no luck).

I will keep playing (probably in dual video mode) to try and make this
thing work.

I will let you know how it goes.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
