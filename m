From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14273.21611.490430.724369@gargle.gargle.HOWL>
Date: Mon, 23 Aug 1999 10:02:19 -0400 (EDT)
To: toa@pop.agri.ch
Cc: Linux-Dev <linuxppc-dev@lists.linuxppc.org>,
        kernel <x-linux-kernel@vger.rutgers.edu>
Subject: MO-Disk on PPC with 53C94 SCSI-chip
In-Reply-To: <37BC482D.7EB2A4AF@pop.agri.ch>
References: <37BC482D.7EB2A4AF@pop.agri.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Andreas <toa@pop.agri.ch> writes -->:
Andreas> Hi,
Andreas> 
Andreas> I have a LinuxPPC R5 system running on a PowerMac 7200 with the
Andreas> 2.2.12pre8 kernel. 
Andreas> My problem is my MO-drive from HP see below for type and SCSI-Spec (it's
Andreas> not SCSI-2)

[other descriptions snipped]

Andreas> The MO is attached to the 53c94, the behavior on the AHA is the same.
Andreas> (as I tried last time)
Andreas> After logging in I inserted a medium and I tried to prepare a fs. It
Andreas> gave tons of errors on 53c94 which forced me to reboot due to SCSI-bus resetting.
Andreas> I used pdisk to try to format the media, this is what it complained:
Andreas> --
Andreas> 53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
Andreas> scsi1 channel 0: resetting for second half of retries.
Andreas> SCSI bus is being reset for host one channel 0.
Andreas> 53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
Andreas> SCSI disk error : host 1 channel 0 id 1 lun 0 return code 27070000
Andreas> scsidisk I/O error: dev 08:14, sector 2
Andreas> --repeating
Andreas> --
Andreas> 
Andreas> This repeats and I have to do the reboot (hard way) becomming stable
Andreas> without the MO.

I have had a similar problem with a repeating SCSI error that didn't clear
until reboot.  I'm running stock 2.2.10 (not vger) on a PowerCenter - also the
53c94.  In my case, I tried to mount a blank CD on my panasonic cw-7502 cdr
drive.

I suspect we're seeing a slightly more generic problem in changeable media,
not just MO.

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
