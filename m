From: Barrie Spence <barrie@calvin.demon.co.uk>
Message-Id: <199907012249.XAA05762@calvin.demon.co.uk>
Date: Thu, 1 Jul 1999 22:49:57 +0000 (GMT)
To: linuxppc-dev@lists.linuxppc.org
Subject: cc/gcc/egcs kernel compilation options?
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As a PPC newbie, why do we need/use "-msoft-float"? Is this 
to handle some processor implementations that don't have 
floating-point hardware? (and if so, does it have any overhead 
on the 603/604/G3 Macs?). If it does have some cost, could it 
not be enabled in the same way as on Intel?

Next question, is there any advantage to building a kernel
with "-mcpu=604 -mtune=604"? (or whatever is most appropriate).

Thanks,
	Barrie


--
Barrie Spence			Sanity Clause? There is no Sanity Clause
Home: barrie@calvin.demon.co.uk		Telephone +44 1506 442304
Play: b.spence@computer.org		

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
