Date: Fri, 3 Nov 2000 16:17:24 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
cc: linuxppc-dev@lists.linuxppc.org, Albrecht@denx.muc.de,
        "[iso-8859-1] Dreﬂ" <ad@mpifr-bonn.mpg.de>,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <Pine.SOL.3.95.1001103151802.20257C-100000@juliet>
Message-ID: <Pine.LNX.4.10.10011031600400.6676-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Make sure you the core adb support is compiled in. It currently is, unless
> > CONFIG_MBX is set ... if CONFIG_ALL_PPC=y implies CONFIG_MBX=y, someone
> > better fix this.
> >
> I suspect it is somehow related to mouse and keyboard being handled by
> the new input layer, in pmac-stable this seems to be handled quite
> differently from pmac-benh (at least, there's an extra config menu).
> Maybe someone forgot that pmu/adb is handling more than keyboard and mouse?

Stupid me. I missed the bit about linux-pmac-stable having that specific
problem. Look at a diff between the Makefiles in both versions.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
