Date: Tue, 5 Sep 2000 08:48:40 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: daenzerm@student.ethz.ch, Gabriel Paubert <paubert@iram.es>,
        Dan Malek <dan@netx4.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <39AEAC18.7EA022BC@execpc.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000905084311.13609F-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Joseph Garcia wrote:

> Michel D舅zer wrote:
> > A few days ago, I rsynced linux-pmac-devel and tried 2.4.0-test7(-pre?) . I
> > had problems with the network, no TCP connection could be established. Anyone
> > seen this?
>
> When I tried 2.4, it takes forever for a name to resolve.  connections seem ok
> once they are made.
>
> My system also seems to have a fork problem in 2.4.  su hangs for 2-3 minutes.
> strace tracks it to a wait that seems to have stalled.  Often, logins and a
> handful of other situations do the same.  I mentioned this to Takashi Oe, as I
> first noticed it when trying his NuBus 2.4 kernel, but he told me it's a 2.4
> thing, possibly relating to VM.  I don't think this is related to the network
> problem, or could it be a wakeup problem?

At least for NuBus kernel, the main cause was very slow disk I/O.  The
latest NuBus 53c(f)9{4,6} driver is much improved in this regard.  I don't
know if you'd still see the mometarily (however long) freezes.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
