Message-ID: <37D4169F.397B9820@generation.net>
Date: Mon, 06 Sep 1999 15:31:43 -0400
From: Simon Piette <spiette@generation.net>
MIME-Version: 1.0
To: toa@pop.agri.ch, LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
References: <37BC482D.7EB2A4AF@pop.agri.ch> <14273.21611.490430.724369@gargle.gargle.HOWL> <37D3A439.3A41F55@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
> 
> Jerry Quinn wrote:
> >
> > Andreas <toa@pop.agri.ch> writes -->:
> > Andreas> Hi,
> > Andreas>
> > Andreas> I have a LinuxPPC R5 system running on a PowerMac 7200 with the
> > Andreas> 2.2.12pre8 kernel.
> > Andreas> My problem is my MO-drive from HP see below for type and SCSI-Spec (it's
> > Andreas> not SCSI-2)
> >
> > [other descriptions snipped]
> >
> > Andreas> The MO is attached to the 53c94, the behavior on the AHA is the same.
> > Andreas> (as I tried last time)
> > Andreas> After logging in I inserted a medium and I tried to prepare a fs. It
> > Andreas> gave tons of errors on 53c94 which forced me to reboot due to SCSI-bus resetting.
> > Andreas> I used pdisk to try to format the media, this is what it complained:
> > Andreas> --
> > Andreas> 53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
> > Andreas> scsi1 channel 0: resetting for second half of retries.
> > Andreas> SCSI bus is being reset for host one channel 0.
> > Andreas> 53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
> > Andreas> SCSI disk error : host 1 channel 0 id 1 lun 0 return code 27070000
> > Andreas> scsidisk I/O error: dev 08:14, sector 2
> > Andreas> --repeating
> > Andreas> --
> > Andreas>
> > Andreas> This repeats and I have to do the reboot (hard way) becomming stable
> > Andreas> without the MO.
> >
> > I have had a similar problem with a repeating SCSI error that didn't clear
> > until reboot.  I'm running stock 2.2.10 (not vger) on a PowerCenter - also the
> > 53c94.  In my case, I tried to mount a blank CD on my panasonic cw-7502 cdr
> > drive.
> >
> > I suspect we're seeing a slightly more generic problem in changeable media,
> > not just MO.
> 
> I made some further tests with my drive. At first I added a SMO-F541 to
> the chain to verify if it is a scsi problem or something else.
> With the sony all went ok on the 53C94 and on the Adaptec-2940UW.
> As stated above the resets on the scsi bus occurs only when no cartridge
> is inserted and I try to mount one. But this only happens on the 53C94
> bus, ont the adaptec it only says bus reseting. And then it does so and
> comes back while on the 53C94 I have to hardboot the machine due to
> repeating scsi resets.
> 
> 
> Summary, I see two problems here, first a 'damned' silly HP-optical
> (C1716T) which really seems to be to old to run perfectly under Linux
> and second, a mac53c94 driver which may have some bugs.
> 
I would tend to say that the 53c94 driver is not perfect, because it's still
impossible to use SANE (scanning software) with it. Anybody succesfully using
the 53c94 to scan, please manifest yourself.

Simon Piette

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
