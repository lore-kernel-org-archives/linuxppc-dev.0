Date: Fri, 9 Aug 2002 23:09:36 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: SCSI (AIC7XXX) broken going from 2.4.19-pre8-ben0 to 2.4.19-ben0
Message-Id: <20020809230936.21a3928d.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just tried upgrading from a 2.4.19-pre8-ben0 kernel to 2.4.19-ben0,
and the first problem I've run into is that it doesn't see any of my
SCSI devices.  With the earler kernel, I would get the following
messages:

Aug  9 13:37:44 gwiz kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVE
R, Rev 6.2.6
Aug  9 13:37:44 gwiz kernel:         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
Aug  9 13:37:44 gwiz kernel:         aic7850: Ultra Single Channel A, SCSI Id=7,
 3/253 SCBs
Aug  9 13:37:44 gwiz kernel:
Aug  9 13:37:44 gwiz kernel:   Vendor: QUANTUM   Model: XP34550S          Rev: L
YK8
Aug  9 13:37:44 gwiz kernel:   Type:   Direct-Access                      ANSI S
CSI revision: 02
Aug  9 13:37:44 gwiz kernel:   Vendor: UMAX      Model: Astra 1220S       Rev: V
1.2
Aug  9 13:37:44 gwiz kernel:   Type:   Scanner                            ANSI S
CSI revision: 02
Aug  9 13:37:44 gwiz kernel:   Vendor: IOMEGA    Model: ZIP 100           Rev: J
.02
Aug  9 13:37:44 gwiz kernel:   Type:   Direct-Access                      ANSI S
CSI revision: 02
Aug  9 13:37:44 gwiz kernel:   Vendor: iomega    Model: jaz 1GB           Rev: J
.86
Aug  9 13:37:44 gwiz kernel:   Type:   Direct-Access                      ANSI S
CSI revision: 02
...

And all was well.  As you can see I am using the AIC7XXX driver.

With the new kernel, all I get is:

Aug  9 13:40:34 gwiz kernel: SCSI subsystem driver Revision: 1.00
Aug  9 13:40:34 gwiz kernel: PCI: Device 11:04.0 not available because of resour
ce collisions
Aug  9 13:40:34 gwiz kernel: mesh: configured for synchronous 5 MB/s
Aug  9 13:40:34 gwiz kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_host
adapter, errno = 2
Aug  9 13:40:34 gwiz last message repeated 3 times

And no SCSI devices are available.

Any ideas about what might be wrong?

						-Thanks

						-Bill

P.S.  I am running a UP kernel on a dual 500 MHz G4 desktop.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
