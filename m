Date: Wed, 28 Jul 1999 19:47:39 -0500 (CDT)
From: "ian reinhart geiser (ADMIN)" <geiseri@msoe.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: I still cannot get L2cr to activate!
In-Reply-To: <XFMail.990728151208.jeremy@goop.org>
Message-ID: <Pine.OSF.3.96.990728194414.19087A-100000@torres.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i ran the get G3 settings from the BootX dist.  it said that i was all
good to go with my l2cr but when i did a:
[19:51:07}{2}{geiseri@sleepchamber:~ (363.537 Mb)>$ cat /proc/sys/kernel/l2cr 

i get:

b9000000:  enabled,no parity,1M,+2 clock,pipelined burst SRAM,ZZ enabled,write-through,1.0ns hold 

as a response...

is this incorrect?

also the l2 cache will not show up in my /proc/cpuinfo

any ideas?

	TIA
	-ian reinhart geiser


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
