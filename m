From: Jeramy B Smith <jsmith@penguinppc.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: SndConfig for Linux/PPC
Date: Fri, 24 Sep 1999 10:46:06 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99092411060800.00471@lintop>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been thinking about making sndconfig run on linuxppc. 
A. rip out the sun/sbus code
B. remove defs for isa cards
C. remove the defs for pci cards that don't work on linuxppc
D. add dma sound def
E. debug, debug, debug

D is giving me the most problems, i guess i shouldnt have to probe but one of
the variabes in the defs is a bustype (isa, pci, sbus). Any ideas what I should
do and what header I would need?

I think a utility like this would help people test their sound system and be
able to diagnose if their sound problems are caused by kernel driver issues or
software (esd, etc) problems.

A utility like this might even be able to incorporate Ben's work at mapping
inputs/outputs by having a machine select screen if dmasound is present. The
user would choose his machine and the correct input/output settings would be
used.


Please feel free to tell me if I'm going about this bass-ackwards ;).



Jeramy B Smith
PenguinPPC.org
jsmith@penguinppc.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
