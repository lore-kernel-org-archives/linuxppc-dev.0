Message-ID: <373C946C.45802CE6@ibm.net>
Date: Fri, 14 May 1999 21:23:56 +0000
From: roboj <roboj@ibm.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: CDROM Problems with 2.2.9
References: <199905130459.XAA18408@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After compiling the recent linux kernel (2.2.9), I've been getting an error
message which I have included below.  I get it at boot time and it continues
printing in an infinite loop.  Also, the computer seems to be trying to access
my cd-rom drive (Toshiba scsi, /dev/scd0 linked to /dev/cdrom). Running power
computing powerbase.  Anyone ever got a similar error message that can offer
any suggestions?  Everything works ok in linux vers. 2.2.6-ac3.


SCSI: aborting command due to timeout pid 3, scsi 0, channel 0, id 1

mesh_abort (c0374000)
mesh: state at c0374278, regs at f3010000 dma at f3008000
ct = 0, seq = c , bs = 6000, fc = 0, exc = 0, err = 0, im = 7, int = 0,
sp = 2, dma stat = c0, cmdptr = 364010, phase = 0, msgphase = 0, comm_tgt = 1,
data_ptr = 0, dma_st = 0, dma_ct = 0, n_msgout = 0

target 1: req = 0374000 goes_out = 0, saved_ptr = 0

SCSI Host 0 abort (pid3) timed out - resetting
SCSI bus is being reset for host 0 channel 0

mesh reset 2
mesh: SCSI bus reset detected: waiting for end...done


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
