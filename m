To: linuxppc-user@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: scsi error playing mp3 file
From: Chris Baker <cbaker@adrenalin.com>
Date: 06 Oct 1999 10:18:11 -0700
Message-ID: <wkzoxwh0h8.fsf@adrenalin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting scsi errors when I try to play an mp3 file.  This happens
in linux playing off an nfs mount and in windows off an smb mount.  I
don't have an mp3 player locally, so I haven't tested it directly.
I've tried deleting the file and recreating it from the cd, but it
still doesn't work.  I assumed that the disk was corrupted, but it
fsck'd without errors.  I haven't had any problems with other files.

Here is the output from /var/log/messages:

Oct  5 20:36:49 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:36:49 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:36:49 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:36:49 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:37:02 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:37:02 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:37:02 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:37:02 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:37:04 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:37:04 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:37:04 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:37:04 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:37:05 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:37:05 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:37:05 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:37:05 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:37:07 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:37:07 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:37:07 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:37:07 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:37:09 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:37:09 trylon kernel: Info fld=0x117b18, Current sd08:14: sense key Medium Error 
Oct  5 20:37:09 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:37:09 trylon kernel: scsidisk I/O error: dev 08:14, sector 113624 
Oct  5 20:38:15 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:15 trylon kernel: Info fld=0x118c88, Current sd08:14: sense key Medium Error 
Oct  5 20:38:15 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:15 trylon kernel: scsidisk I/O error: dev 08:14, sector 118088 
Oct  5 20:38:26 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:26 trylon kernel: Info fld=0x119540, Current sd08:14: sense key Medium Error 
Oct  5 20:38:26 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:26 trylon kernel: scsidisk I/O error: dev 08:14, sector 120320 
Oct  5 20:38:42 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:42 trylon kernel: Info fld=0x118c88, Current sd08:14: sense key Medium Error 
Oct  5 20:38:42 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:42 trylon kernel: scsidisk I/O error: dev 08:14, sector 118088 
Oct  5 20:38:43 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:43 trylon kernel: Info fld=0x118c88, Current sd08:14: sense key Medium Error 
Oct  5 20:38:43 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:43 trylon kernel: scsidisk I/O error: dev 08:14, sector 118088 
Oct  5 20:38:45 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:45 trylon kernel: Info fld=0x118c88, Current sd08:14: sense key Medium Error 
Oct  5 20:38:45 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:45 trylon kernel: scsidisk I/O error: dev 08:14, sector 118088 
Oct  5 20:38:47 trylon kernel: scsi0: MEDIUM ERROR on channel 0, id 6, lun 0, CDB: Request Sense 00 00 00 10 00  
Oct  5 20:38:47 trylon kernel: Info fld=0x118c88, Current sd08:14: sense key Medium Error 
Oct  5 20:38:47 trylon kernel: Additional sense indicates Read retries exhausted 
Oct  5 20:38:47 trylon kernel: scsidisk I/O error: dev 08:14, sector 118088 

This is easily repeatable, but I don't know where to start debugging.
Does anyone have any ideas?

TIA,

cbb


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
