Date: Tue, 12 Jan 1999 13:52:09 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: underperformance of a adaptec UW 2940 attached hard drive
Message-ID: <Pine.LNX.4.05.9901121346020.1161-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


An Ultrastar HD from IBM should give higher performance than it's getting
out of my 2.2.0-pre4 system.
Here's the output from hdparm:
Script started on Tue Jan 12 11:58:30 1999
----
bash# hdparm -Tt /dev/sda

/dev/sda:
 Timing buffer-cache reads:   32 MB in  1.43 seconds =22.38 MB/sec
 Timing buffered disk reads:  16 MB in  1.68 seconds = 9.52 MB/sec
bash# 
----
I should be getting over 20Mb/sec, no?

here's relevant output from dmesg:
Any help should be appreciated.

(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 14/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 419 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.7/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi1 : MESH
scsi2 : 53C94
scsi : 3 hosts.
  Vendor: IBM       Model: DGVS09U           Rev: 03B0
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 5, lun 0
mesh: target 0 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300N
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 0, lun 0
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
mesh: target 6 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300N
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 6, lun 0
  Vendor: SEAGATE   Model: ST12550N          Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi2, channel 0, id 4, lun 0
scsi : detected 1 SCSI cdrom 4 SCSI disks total.
Uniform CDROM driver Revision: 2.51
(scsi0:0:5:0) Synchronous at 40.0 Mbyte/sec, offset 8.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17829870 [8705 MB] [8.7
GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 4124736 [2014 MB] [2.0
GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 4124736 [2014 MB] [2.0
GB]
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 4178874 [2040 MB] [2.0
GB]



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
