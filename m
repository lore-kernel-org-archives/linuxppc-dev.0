Date: Sun, 14 Mar 1999 14:35:58 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Blue G3 and machine check
Message-Id: <19990314143558.014768@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While reading of macbsd mailing list, I've seen that the Blue G3 causes a
machine check exception while probing a non-existing PCI slot. I don't
have time to look into this and I don't have one of those machines, but
if anyone want to give a try at fixing this...

(With luck, the second PCI bridge will have been properly setup by OF or
BootX and this fix could be enough to get the machine to boot further
that It's doing now).

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
