Message-ID: <398DD37B.76A60CC7@ncal.verio.com>
Date: Sun, 06 Aug 2000 14:07:07 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


References: <398A91CA.F8D3C489@student.ethz.ch>

Michel Dänzer wrote:
>
> Henry Worth wrote:
>
> > Rebuilding the kernel to use SCSI generic devices with IDE SCSI
> > emulation produced much better, even usable, results. At startup
> > there are still a couple of dropouts in the first few seconds,
> > but after that the playback is clean across multiple tracks (even
> > with a concurrent kernel compile). Piping cdparanoia to /dev/null
> > shows data rates of 187sectors/sec at all -S settings (and default).
> > From the the drive's spin-up sounds it seems to always be in
> > high-speed mode, but unlike the ATAPI driver, there is little
> > head movement noise.
>
> Does it also improve audio grabbing? With 2.2.15, both IDE and SCSI emulation
> almost killed the system...
>

Haven't seen any instability between the two interfaces
(2.2.17pre15-ben1, though I have had a number of sponstaneous
powerdowns when using the modem this weekend -- the PMU gets testy
when it doesn't get immediate attention, a problem with at least the
recent kernels -- haven't used the modem much with the early
Pismo capable kernels). With cdparanoia's error correction enabled
the SCSI interface is about 30-50% faster ripping tracks (~2-3X). With
the error correction disabled (-Z), both interfaces are the same
speed (~6X) and I get files that compare identically.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
