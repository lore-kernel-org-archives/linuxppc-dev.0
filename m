From: Thomas Capricelli <capricel@enst.fr>
Reply-To: capricel@enst.fr
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.3-ac4 on 7600
Date: Tue, 23 Mar 1999 11:13:16 +0100
Content-Type: text/plain
References: <001c01be7482$0565a2f0$020210ac@paso.atasd.com>
MIME-Version: 1.0
Message-Id: <99032311223500.06215@gauss>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




>Are there any other packages I should update? Anyone try 2.2.3-ac4 yet (I
>probably will this week)?

I've tried it yesterday, using a modified R4 (the one I got in august 98). I
Also use modutils 2.1.125.
I've got some difficulties to make it boot (first scsi disk not syncing) but
I've finally got it running. The two main problems which still prevent me from
using it as my main kernel are :

	Some modules have undefined symbol ("memcpy" for most of them), some
are ok (hfs,loop)  Dmasound won't be loaded :-( while soundcore will
 	The vmode I do in /etc/rc.d/rc doesn't seem to be done, making
my kde to boot in a much too bad screen resolution. (but it works if I do it by
hand later, ?)

	A little funny bug, is that the screen #1 isn't refreshed when swapping
console from X.

info about the problem with disk1 not syncing can be found on
http://www.ecoledoc.lip6.fr/~capricel/coding/kernel222.html
It's probably due to the fact that the box is a PowerMac 7600 with the OF bug.

If anybody is interested in more details, just ask.

 Thomas
--

Thomas Capricelli	<capricel@enst.fr>
http://www.ecoledoc.lip6.fr/~capricel/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
