MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <15217.8602.545455.836867@mediaone.net>
Date: Wed, 8 Aug 2001 07:25:14 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: daenzer@debian.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <3B708C81.DE87DDC2@iiic.ethz.ch>
References: <Pine.LNX.4.05.10108070947420.5836-100000@callisto.of.borg>
	<3B708C81.DE87DDC2@iiic.ethz.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > > video=mode specifies the global mode, for all fbdevs that use modedb.
 >
 > Ah, cool. So what's your theory on why it didn't work for R?


I'm also curious about this.

Is video=1280x1024-8@60 supposed to haved worked?  It doesn't work for
me, but video=atyfb128:1280x1024-8@60 does work -- does that mean my
system is misconfigured in some way?  If so I'd like to fix it.  I'm
running 2.4.8-pre3-ben0 on a G4/450 with a Rage128 graphics card, a
DVIator dvi->adc adapter, and an Apple lcd17.  dmesg says:

aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 160x64
fb0: ATY Rage128 frame buffer device on PCI



--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
