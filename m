Date: Thu, 2 Aug 2001 14:33:21 +0200
From: Olaf Hering <olh@suse.de>
To: Arne Kovac <kovac@zeus.stat-math.uni-essen.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again booting 43p-140
Message-ID: <20010802143321.A9527@suse.de>
References: <20010802133643.A14272@suse.de> <Pine.A41.4.10.10108021426280.20690-100000@zeus.stat-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.A41.4.10.10108021426280.20690-100000@zeus.stat-math.uni-essen.de>; from kovac@zeus.stat-math.uni-essen.de on Thu, Aug 02, 2001 at 02:30:30PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 02, Arne Kovac wrote:

> On Thu, 2 Aug 2001, Olaf Hering wrote:
>
> > Can you try one of these images?
> > based on linuxppc_2_4
> > /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/deflt/zImage.chrp-rs6k
> >
> > based on linuxppc_2_4_devel
> > /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/sleep/zImage.chrp-rs6k
> >
> > One guy reported that it boots with a plain kernel.org tree, so it cant
> > be too hard.
>
> No, that doesn't work either. The 43p says:
>
>
> INIT-PROGRAM: ELF-LOADER
> Endian Mode: Load Address = 1000000
>
> ... [lots of symbols and numbers]
>
> exiting ELF section
> exit INIT-PROGRAM: ELF-LOADER

can you try the .chrp and .prep files? I think prep needs a different
way to boot (dd onto the floppy?).


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
