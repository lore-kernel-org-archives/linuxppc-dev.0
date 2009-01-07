Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 0/6] ps3vram driver patches
Date: Wed, 7 Jan 2009 20:53:05 +0100
References: <4963CDCA.4080802@am.sony.com> <200901071944.45680.arnd@arndb.de>
	<49650128.8020200@am.sony.com>
In-Reply-To: <49650128.8020200@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901072053.06037.arnd@arndb.de>
Cc: David Woodhouse <David.Woodhouse@intel.com>, Jim Paris <jim@jtan.com>,
	linux-mtd@lists.infradead.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009, Geoff Levand wrote:

> Geert and I were discussing actually removing the direct write to the XDR
> memory, and so the need for that ioremap, as the mapping is just used in
> ps3vram_erase(), which seems could be removed.

Ah, I see. I also forgot to mention that the ioremap_flags change should
only be done for actual memory regions, but *not* for memory mapped I/O
registers.

> I want to get it converted to a block device, and I will work towards
> that, but it will take some time. =A0As it is, it is very useful for typi=
cal
> systems that are running full desktops like gmome or KDE and do a lot of
> swapping. =A0Many of the distros now use it, and users want it.

Yes, fine by me.

	Arnd <><
