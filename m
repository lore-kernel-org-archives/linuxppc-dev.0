Date: Mon, 20 Mar 2000 11:16:09 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound split
In-Reply-To: <Pine.GSO.4.10.10003201107330.17246-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003201114070.3889-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Anything missing, Geert?
>
> Isn't this the problem where dmasound_init() is no longer called? I forgot to
> update the #ifdef CONFIG_DMASOUND since I never tried it builtin.

Sounds possible.

> I received a patch to call it on #ifdef CONFIG_DMASOUND_*.

Meaning #if defined(CONFIG_DMASOUND_AWACS) || defined(CONFIG_DMASOUND_ATARI) .. ?

I'll try that, could you forward that patch if it's something else ??

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
