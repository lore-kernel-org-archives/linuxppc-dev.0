Message-ID: <3CDF867F.44DA2DAD@folkwang-hochschule.de>
Date: Mon, 13 May 2002 11:25:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: alsa-devel@lists.sourceforge.net,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: unresolved symbol udelay with ALSA on PPC
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi !

sorry for crossposting, this one is probably inappropriate for either
the alsa or the ppc list. the problem is, i don't know which ;)

this is after successfully compiling 2.4.19-pre8-ben0 for PPC on a
powerbook g3 (pismo) and installing the alsa drivers from
alsa-driver-0.9.0rc1.tar.bz2:

ephraim:/usr/src/alsa-driver-0.9.0rc1 # depmod -ae -F
/boot/System.map-2.4.19-pre8-ben0
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ben0/kernel/sound/ppc/snd-powermac.o
depmod:         udelay

can anyone clue me in on this ? i grepped for udelay, but it seems it's
a very popular string in the source tree, so i gave up :( it seems to be
defined alright for other kernel modules. afaics, snd-powermac is the
only one that has problems.

thanks in advance,

jörn



--
Watch out where the huskies go and don't you eat
the yellow snow !
	- Frank Zappa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
