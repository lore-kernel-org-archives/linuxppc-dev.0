Date: Sun, 19 Sep 1999 16:37:11 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Compiling 2.3.18
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9909191611110.1836-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have no success at compiling (actually just doing make dep) the
2.3.18 kernel source I downloaded from linuxppc.cs.nmt.edu (I think
it is from Dave's source tree). I am getting the following error:

make -C sound fastdep
make[4]: Entering directory `/usr/src/linux-2.3.18.embedded/drivers/sound'
.depend.69: *** unterminated call to function `wildcard': missing `)'.
Stop.
make[4]: Leaving directory `/usr/src/linux-2.3.18.embedded/drviers/sound'
make[3]: *** [_sfdep_sound] Error 2

etc.


There is no function `wildcard' in any files, except for Makefile.

I tried with different .config files, including the default file created
by make xconfig.

I downloaded 2.3.18 from edge.kernelnotes.org and I am able to compile
(after fixing one of the Config.in file).

Could it be a problem with Dave's tar (as for fadsrom.tar)?

I am targetting a board with an MPC8xx, does the source from the
embedded tree at linuxppc.cs.nmt.edu better than the one from
cutting edge (if I can compile it !!), i.e. it there required
stuff that only appears in the embedded source tree?

Thanks

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
