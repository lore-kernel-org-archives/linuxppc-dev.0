Message-ID: <36DA3D05.2E16F658@talknet.de>
Date: Mon, 01 Mar 1999 07:08:53 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: linux-2.2.2 kernel hangs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday I managed to update my kernel sources to 2.2.2 from
vger/linux
at cvs.samba.org. There was some restructuring on samba and I had to
find
out how to update my Repository and Root CVS files.

This 2.2.2 version has severe problems on a Motorola RiscPC. Actually
the
kernel hangs within a short time if cpio'ing files from a NFS tree to
the
local scsi drive. It starts with a message about the nfs server not
responding and than endlessly repeats scsi timeouts. Due to my problems
with CVS I do not have any of the versions between 2.1.130 and 2.2.2.
The
2.1.130 version did not show the problem.

Is this a known problem.
Did anybody else experiance the same problem. 


Here is a sample output:

nfs: server dino not responding, still trying
scsi : aborting command due to timeout : pid 3940, scsi0, channel 0, id
0, lun 0 0x0a 02 ff c0 80 00
ncr53c8xx_abort: pid=3940 serial_number=3947
serial_number_at_timeout=3947
scsi : aborting command due to timeout : pid 3941, scsi0, channel 0, id
0, lun 0 0x0a 03 00 5a 02 00
ncr53c8xx_abort: pid=3941 serial_number=3948
serial_number_at_timeout=3948
ncr53c810-0: abort ccb=c0195020 (cancel)
SCSI host 0 abort (pid 3941) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=3941 reset_flags=2 serial_number=3948
serial_number_at_timeout=3948
SCSI host 0 abort (pid 3941) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=3941 reset_flags=2 serial_number=3949
serial_number_at_timeout=3949
SCSI host 0 abort (pid 3941) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=3941 reset_flags=2 serial_number=3951
serial_number_at_timeout=3951
SCSI host 0 abort (pid 3941) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
ncr53c8xx_reset: pid=3941 reset_flags=2 serial_number=3953
serial_number_at_timeout=3953


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
