Date: Thu, 2 Aug 2001 13:36:43 +0200
From: Olaf Hering <olh@suse.de>
To: Arne Kovac <kovac@zeus.stat-math.uni-essen.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again booting 43p-140
Message-ID: <20010802133643.A14272@suse.de>
References: <Pine.A41.4.10.10108021316500.20690-100000@zeus.stat-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.A41.4.10.10108021316500.20690-100000@zeus.stat-math.uni-essen.de>; from kovac@zeus.stat-math.uni-essen.de on Thu, Aug 02, 2001 at 01:26:56PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 02, Arne Kovac wrote:

>
> Hi all,
>
> I also tried to install Linux on the 43p-140. This is what I did:
>
> 1) Updated the firmware to the latest release.
>
> 2) Installed a GXT130P in Slot 1 (closest to the motherboard).
>
> 3) Copied a zImage from SuSEs FTP server:
>
> ftp://ftp.suse.com/pub/suse/ppc/7.1/unsorted/prep/43p_140/zImage.140.chrp
>
> on an msdos floppy.
>
> 4) Booted to the OpenFirmware prompt and typed
>
> 0> setenv real-base c00000
> 0> setenv load-base 200000
> 0> boot floppy:,\zImage root=/dev/fd0 load_ramdisk=1 ramdisk_size=128000
>
> 5) Now the 43p-140 loads from disk and writes several lines on the screen,
> last one: "Checking the display". Then the screen is cleared and the
> following text appears
>
> Copying OF device tree .............................................. done
> returning 00010000 from prom_init
> IBM,7043-140: reprogramming the memory controller
>
> 6) Then nothing happens
>
> Any idea what I can do?

Can you try one of these images?
based on linuxppc_2_4
/mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/deflt/zImage.chrp-rs6k

based on linuxppc_2_4_devel
/mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/sleep/zImage.chrp-rs6k

One guy reported that it boots with a plain kernel.org tree, so it cant
be too hard.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
