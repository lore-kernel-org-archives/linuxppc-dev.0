Message-ID: <F14441D40E5AD3118886005004607AD10BDE8C@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'Christof Petig'" <christof.petig@wtal.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: AW: Sound on an iBook?
Date: Fri, 8 Dec 2000 09:38:22 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christof Petig <mailto:christof.petig@wtal.de> wrote:
>
> Hello,
>
> I got no answer on the debian-ppc list, so I'll try here.
>
> does anybody know a way to get the sound hardware on my iBook working?
> Everything else is working fine.
>

The iBook has a different Hardware than all other Macs found so far.

There is an (unsupported, ugly ...) version of dmasound that
sometimes works on iBooks, but it provides no control of the
output, it just takes what OF or MacOS left behind. So using
such a Kernel/Module is a kind of russian roulette because it
will block forever when intializing fails.

This issue needs a good assembler-/Forth- Programmer that must
use MacsBug in MacOS or dissassemble the OF to find out whats
going on there. I'd really like to do that but that is nothing
I can do when going to work by train ....

              |          __    hasi@penguinppc.org
+--------+    |   |\  | |  \
| +----+ |    v   | \ | |__/   Klaus Halfmann
| |... | |   .^.  |  \| |      Kirchstraﬂe 24a
| |..  | |  <   >      |       67691 Hochspeyer
| +----+ |   'v'       |
|_____==_|+==-------------==+  GERMANY
 |      | |   --__  __--    |
 +------+ +-------==--------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
