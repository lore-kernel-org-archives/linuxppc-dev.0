Message-ID: <38EF891E.5D14C524@home.com>
Date: Sat, 08 Apr 2000 12:31:42 -0700
From: Robert Shaw <rshaw-az@home.com>
Reply-To: rshawppc@yahoo.com
MIME-Version: 1.0
To: jpd@yami.w-d.org
CC: rshaw@linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue & White & SCSI & Ultra 2 SCSI & Kernel > 2.2.10 -> No Disks
References: <38EF50E4.872D76ED@w-d.org>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Doty wrote:

> We have finally gotten partway to the bottom of this. Apparently, if the
> 2930 controller is present the kernel cannot find the 2940 controller
> (and the 2940 has the disks on it). With the 2930 pulled (I don't really
> need it the way I'm currently using the system), SCSI works fine with
> the newer kernels.

Yes, I've found this issue with the latest kernels with someone else as
well. Do any of the SCSI driver developers out there know what might be
causing this? Apparently, when there are more than one Adaptec SCSI
controllers (doesn't seem to matter which ones, but most notably a narrow
controller and a wide controller combo), the SCSI driver freaks out and
does not recognize either properly.

--
-Robert


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
