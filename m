Date: Sun, 3 Jan 1999 20:42:07 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.0p4 ignores one of my drives
Message-ID: <Pine.LNX.3.96LJ1.1b7.990103204043.696A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi...

after making the 2.1.130 (2 jan vger) -> 2.2.0pre4 (3 jan vger)
upgrade, linux can't see one of my hard drives any more.

this is a drive that mklinux has never been able to see so i always
thought of linuxppc as being very robust in finding it and being able
to access it. the drive contains my macos startup volume and macos
never has trouble with it.

i use a 7500 with a 604 upgrade, two internal hard drives, a slew of
devices on the external bus.

before:

Jan  3 19:39:22 cricket kernel: mesh: target 1 synchronous at 5.0 MB/s
Jan  3 19:39:22 cricket kernel:   Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G
Jan  3 19:39:22 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0

after:

Jan  3 20:14:44 cricket kernel: mesh: target 1 aborted

brad

fwiw, here are the full logs:

Jan  3 19:39:22 cricket kernel: scsi0 : MESH
Jan  3 19:39:22 cricket kernel: scsi1 : 53C94
Jan  3 19:39:22 cricket kernel: scsi : 2 hosts.
Jan  3 19:39:22 cricket kernel: mesh: target 0 synchronous at 5.0 MB/s
Jan  3 19:39:22 cricket kernel:   Vendor: QUANTUM   Model: PD1225S           Rev: 3110
Jan  3 19:39:22 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Jan  3 19:39:22 cricket kernel: mesh: target 1 synchronous at 5.0 MB/s
Jan  3 19:39:22 cricket kernel:   Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G
Jan  3 19:39:22 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Jan  3 19:39:22 cricket kernel: mesh: target 3 synchronous at 4.2 MB/s
Jan  3 19:39:22 cricket kernel:   Vendor: SONY      Model: CD-ROM CDU-8005   Rev: 1.0j
Jan  3 19:39:22 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Jan  3 19:39:22 cricket kernel:   Vendor: SEAGATE   Model: ST32550N          Rev: 0022
Jan  3 19:39:22 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi disk sdc at scsi1, channel 0, id 1, lun 0
Jan  3 19:39:22 cricket kernel:   Vendor: iomega    Model: jaz 1GB           Rev: H.62
Jan  3 19:39:22 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi removable disk sdd at scsi1, channel 0, id 2, lun 0
Jan  3 19:39:22 cricket kernel:   Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.04
Jan  3 19:39:22 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi CD-ROM sr1 at scsi1, channel 0, id 3, lun 0
Jan  3 19:39:22 cricket kernel:   Vendor: RICOH     Model: MP6201S           Rev: 2.20
Jan  3 19:39:22 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi CD-ROM sr2 at scsi1, channel 0, id 4, lun 0
Jan  3 19:39:22 cricket kernel:   Vendor: UMAX      Model: Astra 1200S       Rev: V1.3
Jan  3 19:39:22 cricket kernel:   Type:   Scanner                            ANSI SCSI revision: 02
Jan  3 19:39:22 cricket kernel: Detected scsi generic sgh at scsi1, channel 0, id 5, lun 0
Jan  3 19:39:22 cricket kernel: scsi : detected 3 SCSI cdroms 4 SCSI disks total.

Jan  3 20:14:44 cricket kernel: scsi0 : MESH
Jan  3 20:14:44 cricket kernel: scsi1 : 53C94
Jan  3 20:14:44 cricket kernel: scsi : 2 hosts.
Jan  3 20:14:44 cricket kernel: mesh: target 0 synchronous at 5.0 MB/s
Jan  3 20:14:44 cricket kernel:   Vendor: QUANTUM   Model: PD1225S           Rev: 3110
Jan  3 20:14:44 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Jan  3 20:14:44 cricket kernel: mesh: target 1 aborted
Jan  3 20:14:44 cricket kernel: mesh: target 3 synchronous at 4.2 MB/s
Jan  3 20:14:44 cricket kernel:   Vendor: SONY      Model: CD-ROM CDU-8005   Rev: 1.0j
Jan  3 20:14:44 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Jan  3 20:14:44 cricket kernel:   Vendor: SEAGATE   Model: ST32550N          Rev: 0022
Jan  3 20:14:44 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi disk sdb at scsi1, channel 0, id 1, lun 0
Jan  3 20:14:44 cricket kernel:   Vendor: iomega    Model: jaz 1GB           Rev: H.62
Jan  3 20:14:44 cricket kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi removable disk sdc at scsi1, channel 0, id 2, lun 0
Jan  3 20:14:44 cricket kernel:   Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.04
Jan  3 20:14:44 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi CD-ROM sr1 at scsi1, channel 0, id 3, lun 0
Jan  3 20:14:44 cricket kernel:   Vendor: RICOH     Model: MP6201S           Rev: 2.20
Jan  3 20:14:44 cricket kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi CD-ROM sr2 at scsi1, channel 0, id 4, lun 0
Jan  3 20:14:44 cricket kernel:   Vendor: UMAX      Model: Astra 1200S       Rev: V1.3
Jan  3 20:14:44 cricket kernel:   Type:   Scanner                            ANSI SCSI revision: 02
Jan  3 20:14:44 cricket kernel: Detected scsi generic sgg at scsi1, channel 0, id 5, lun 0
Jan  3 20:14:44 cricket kernel: scsi : detected 3 SCSI cdroms 3 SCSI disks total.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
