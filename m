Message-ID: <001801c11b22$557edce0$5b9e8aa3@cello>
From: "kenji mac" <kenji114@mac.com>
To: <linuxppc-dev@lists.linuxppc.org>
References: <3B688167.9010906@hadess.net>
Subject: POS 2.4G card
Date: Thu, 2 Aug 2001 16:11:21 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, I am new to this list.

now i am porting the driver for 2.4G POS PCI cards to linuxppc.
and succeeded!

but i will never be able to see the max transmisson performance as
the developing environment is on the PowerMacintosh 8500/150 ;-(
(kernel 2.2.17 Vinelinux2.1CR)

actually the output of netperf test is about 180Mbps while it could be
2.3Gbps on Intel/Linux driver.

so i made up my mind to buy the fastest machine to test the max performance
on linuxppc.

and, I have a simple question. I think new Apple G4 is the fastest machine,
having
some troubles about Geforce video cards for booting linuxppc.
then, Can I take the story below for boot linuxppc on Apple new G4?

1) put yaboot files in System folder , using Geforce. and shutdown.
2) change the video card to supported video cards in
(http://linuxppc.org/hardware/videocards/index.php3?css_ok=1)
3) then boot linuxppc install cd.

Is it Okay??

I think it's great to realize the 2.4G transmission on PowerMac(linuxppc)!!

kenji in japan.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
