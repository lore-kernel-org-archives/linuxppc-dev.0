Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A34B67B1A
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 09:40:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Matthew T. Atkinson" <matthew@agrip.org.uk>
In-Reply-To: <1113081689.15872.4.camel@localhost>
References: <1113006674.9568.414.camel@gaston>
	<1113081689.15872.4.camel@localhost>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 09:38:27 +1000
Message-Id: <1113089907.9517.446.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-04-09 at 22:21 +0100, Matthew T. Atkinson wrote:
> 'ello,
> 
> On Sat, 2005-04-09 at 10:31 +1000, Benjamin Herrenschmidt wrote:
> > echo `cat /proc/device-tree/model`
> 
> PowerBook5,4
> 
> > for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
> 
> /proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound/layout-id
> 0000000 0000 0033
> 0000004
> 
> For your information, in case this helps...
> 
> I am using ALSA and it appears to work except that only one program can
> access the sound hardware at a time (so is just like OSS :-)).  If I am
> playing music in XMMS and then try to aplay a .wav file, it will hang
> until XMMS is closed for example.

If you set apps like xmms to actually use alsa output, you can have
mixing but for that, you have to enable the dmix plugin in your alsa
config. Look for infos about that on this list archive.

> The trick of altering the HZ of mp3 plug-in to remove the choppiness
> doesn't seem to work for all mp3 files (thought does for the vast
> majority).
> 
> Many thanks for looking into this (and all the other work you do --
> sleep support, for example, has been *incredibly* useful)!
> 
> best regards,
> 
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
