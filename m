Date: Mon, 13 May 2002 11:34:19 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Alsa-devel] unresolved symbol udelay with ALSA on PPC
In-Reply-To: <3CDF867F.44DA2DAD@folkwang-hochschule.de>
Message-ID: <Pine.LNX.4.33.0205131133210.472-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 May 2002, [iso-8859-1] Jörn Nettingsmeier wrote:

> hi !
>
> sorry for crossposting, this one is probably inappropriate for either
> the alsa or the ppc list. the problem is, i don't know which ;)
>
> this is after successfully compiling 2.4.19-pre8-ben0 for PPC on a
> powerbook g3 (pismo) and installing the alsa drivers from
> alsa-driver-0.9.0rc1.tar.bz2:
>
> ephraim:/usr/src/alsa-driver-0.9.0rc1 # depmod -ae -F
> /boot/System.map-2.4.19-pre8-ben0
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre8-ben0/kernel/sound/ppc/snd-powermac.o
> depmod:         udelay
>
> can anyone clue me in on this ? i grepped for udelay, but it seems it's
> a very popular string in the source tree, so i gave up :( it seems to be
> defined alright for other kernel modules. afaics, snd-powermac is the
> only one that has problems.

I think that we fixed this problem in CVS. Probably, inclusion of
<linux/delay.h> header file was missing.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
