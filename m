Date: Tue, 17 Jul 2001 03:18:27 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Subject: Re: 2.4 - buttons, temperature, ictc
Message-Id: <20010717031827.72f983c2.jpgarcia@execpc.com>
In-Reply-To: <Pine.LNX.4.05.10107170917410.10614-100000@callisto.of.borg>
References: <20010717004540.255d1b2c.jpgarcia@execpc.com>
	<Pine.LNX.4.05.10107170917410.10614-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Jul 2001 09:18:53 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 17 Jul 2001, Joseph P. Garcia wrote:
> > - small ATY resource tweak in pmac_pci.c (I like it at 0x830--.  not sure if 0x800-- is best or not.  ignore if you like.)
>
> Why is it necessary to hardcode this address? It may clash with another device.

Truth told, it isn't necessary anymore.  All this does is put the video control memory on wallstreets (it checks) at 0x830-- rather than 0x800--, which is where the current kernel puts it iirc.  A leftover from the days of the OF-caused ATY memory overlap.  Now, this mostly just makes /proc/iomem look cleaner.  nothing more.

That segment (the whole pmac_pci.c section of the patch) does only that, and can be ignored.  Don't know why i posted that part to tell the truth.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
