Date: Wed, 17 Mar 1999 16:25:18 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Apple Open Source: the drivers
Message-Id: <19990317162518.010351@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I finally found where the driver are hidden: In the kernel archive,
in bsd/dev/ppc. They are mostly objective C drivers. Among other things,
there are drivers for the PowerMac ATA with apparently all the timing
stuffs, and for the CMD646 controller in the blue G3.

There's a PMU driver with apparently up-to-date command length tables and
lots of comments about the commands ;-) An interesting thing that I've
not seen in the LinuxPPC driver: When sending read commands to
non-existing devices, the PMU may never answer, and so there's need for
some kind of timeout. I didn't find infos about putting the PowerBook to
sleep, maybe MacOS X Server cannot sleep...

Finally, the MESH driver is a piece of anthology, but I'll let interested
people discover it by themselves ;-)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
