Date: Fri, 24 Sep 1999 18:01:36 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: MacOS 9 vs. linux IDE
Message-Id: <19990924180136.017702@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've done some experiments with MacOS 9. Apparently, the IDE controller
is in a strange state after MacOS shutdown, and this is not related to
the feature control bits of the mac-io. However, I managed to revive it
after writing various values in the IDE control register (+0x160).

It looks like Apple uses bits in the MSB quartet of the IDE control
register, which are, to my knowledge, not defined by the standard.

Someone has an idea about this ? I'll continue my tests until I find
something that works all the time.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
