Message-ID: <398A91CA.F8D3C489@student.ethz.ch>
Date: Fri, 04 Aug 2000 11:50:02 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <398A522C.77172439@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:

> Rebuilding the kernel to use SCSI generic devices with IDE SCSI
> emulation produced much better, even usable, results. At startup
> there are still a couple of dropouts in the first few seconds,
> but after that the playback is clean across multiple tracks (even
> with a concurrent kernel compile). Piping cdparanoia to /dev/null
> shows data rates of 187sectors/sec at all -S settings (and default).
> From the the drive's spin-up sounds it seems to always be in
> high-speed mode, but unlike the ATAPI driver, there is little
> head movement noise.

Does it also improve audio grabbing? With 2.2.15, both IDE and SCSI emulation
almost killed the system...


Michel


--
Columbus had a fourth ship. It sailed over the edge.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
