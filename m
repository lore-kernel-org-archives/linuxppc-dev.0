Date: Thu, 2 Aug 2001 14:30:30 +0200 (DFT)
From: Arne Kovac <kovac@zeus.stat-math.uni-essen.de>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again booting 43p-140
In-Reply-To: <20010802133643.A14272@suse.de>
Message-ID: <Pine.A41.4.10.10108021426280.20690-100000@zeus.stat-math.uni-essen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2 Aug 2001, Olaf Hering wrote:

> Can you try one of these images?
> based on linuxppc_2_4
> /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/deflt/zImage.chrp-rs6k
>
> based on linuxppc_2_4_devel
> /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/sleep/zImage.chrp-rs6k
>
> One guy reported that it boots with a plain kernel.org tree, so it cant
> be too hard.

No, that doesn't work either. The 43p says:


INIT-PROGRAM: ELF-LOADER
Endian Mode: Load Address = 1000000

... [lots of symbols and numbers]

exiting ELF section
exit INIT-PROGRAM: ELF-LOADER



Arne


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
