Message-ID: <F14441D40E5AD3118886005004607AD10BDE55@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: "'Douglas M. Lowder'" <dlowder@mvista.com>
Subject: AW: [linuxppc-dev] Sound and sleep support for iBook?
Date: Tue, 28 Nov 2000 08:29:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Douglas M. Lowder [mailto:dlowder@mvista.com] wrote:
>
> I am using kernel 2.2.17pre20-ben3 (from Benjamin Herrenschmidt's
> site) and everything else on the system is well supported.
> I would be very interested in getting information on the
> last two gaps in hardware support, namely sound and power
> management.  Anyone out there made progress on this lately?
>
> -Doug Lowder

Powermangement works partially when using pmud (Download via
www.penguinppc.org) Sleep does not work and if it does (BenH
had some kernels that tried) it does not wake up anymore.
Upto now nobody found out what needs to be done here. The
Darvin sources may contain hints. You can however use
pmud to shut down the iBook when power is low or the lid is
closed. Im unsure if the "nap"-mode works at all.

There is an (unsupported, ugly ...) version of dmasound that
sometimes works on iBooks, but it provides no control of the
output, it just takes what OF or MacOS left behind. So using
such a Kernel/Module is a kind of russian roulette because it
will block forever when intializing fails.

Both issues need a good assembler-/Forth- Programmer that must
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
