Date: Sun, 22 Apr 2001 23:42:48 +0100
Subject: Re: Sound problem on Blue G3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Christian Groessler <cpg@aladdin.de>,
	linuxppc-dev@lists.linuxppc.org
Cc: cpg@aladdin.de
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010422224336.0F7ED2F03D@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Christian,

I take it from the first part of your message that sound is OK on the
g3/beige (I certainly hope so - that's the machine I test most on ;-)

> I tried the current PPC patches from kernel.org (patch-2.4.4-pre4.bz2
> and linuxppc2.4_vs_v2.4.4-pre4.patch.bz2), but except for a rename of
> the sound driver module (dmasound_awacs -> dmasound_pmac) nothing
> changed (I.e. the sound still doesn't work!)

Hmm.  can you send me the output of "cat /dev/sndstat" please. and tell me
if you have the "burgundy" sound chip (I think you do).

> How can I get the sound working on the Blue G3?

well, you could try applying the following two patches (I updated earlier
this pm):

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.4p4-dmasound/dmas-2.4.4
p4-1.diff.bz2

and

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.4p4-dmasound/dmas-2.4.4
p4-2.diff.bz2

(both need to be applied)... you should be able just to "make dep modules"
and "make modules_install" and go from there.

what desktop?
could you make sure that things aren't getting futzed by the mixer - I know
this sounds a little dumb - but could you try adjusting the levels of
speaker and input... even if they look like they are OK.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
