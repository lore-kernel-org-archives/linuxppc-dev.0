Subject: Re: No Subject
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0401251223440.20527@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0401251223440.20527@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1075035753.874.14.camel@gaston>
Mime-Version: 1.0
Date: Mon, 26 Jan 2004 00:02:33 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-25 at 22:31, Geert Uytterhoeven wrote:
> 	Hi,
>
> This patch converts <asm/hydra.h> to use explicit-sized types.
> It also applies to 2.4.

Don't you want to port the Hydra code to use the macio infrastructure ?

It would probably require defining the LongTrail as a _MACH_Pmac or
hacking enough of pmac_feature to grok it, but that doesn't seem to
bad actually...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
