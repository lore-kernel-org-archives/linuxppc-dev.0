From: Benjamin Herrenschmidt <bh40@calva.net>
To: <cl.en@gmx.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re:  quik-1.3.1and 2.2.16_pmac-stable ?
Date: Sat, 17 Jun 2000 01:34:16 +0200
Message-Id: <20000616233416.1720@mailhost.mipsys.com>
In-Reply-To: <20000617010541.B508@olis.north.de>
References: <20000617010541.B508@olis.north.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 17, 2000, Claus Enneper <cl.en@gmx.net> wrote:

>
>all (prom_version) have their RELOC, so that's not the point.
>unfortunatly, I'm not able to make a diff to 2.2.15pre14 to see the
>difference.


Ah, yes, it's a different issue. You should probably use a more recent
quik (2.0+) to work with recent kernels. Old quik doesn't like the new
kernel entry point (without the pseudo-xcoff hack).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
