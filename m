Return-Path: <acrux_it@libero.it>
Received: from cp-out10.libero.it (cp-out10.libero.it [212.52.84.110])
	by ozlabs.org (Postfix) with ESMTP id 4719BB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 06:07:06 +1100 (EST)
Received: from hermes (151.53.95.114) by cp-out10.libero.it (8.5.133)
	(authenticated as acrux_it@libero.it)
	id 4D4A5DCB0105FCDB for linuxppc-dev@lists.ozlabs.org;
	Thu, 10 Feb 2011 20:01:16 +0100
Date: Thu, 10 Feb 2011 20:01:16 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: ydl powerstation is unable to use external usb hard disk drives
Message-Id: <20110210200116.0b11baab.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


i'm a bit in trouble when i try to use an external usb hard disk drive on 
our YDL Powerstation (2x PPC970MP). 
Sombody is able to suggest me a solution? Instead, on my iBook G4, everything is working fine.

Actually i don't have another ppc64 to do further attempts. 



# YDL Powerstation (Bimini) (kernel linux-2.6.38-rc4)

usb 1-2: new high speed USB device using ehci_hcd and address 2
usb 1-2: New USB device found, idVendor=04b4, idProduct=6830
usb 1-2: New USB device strings: Mfr=0, Product=57, SerialNumber=44
usb 1-2: Product: Cypress AT2LP
usb 1-2: SerialNumber: DEF10CE2CF76
scsi3 : usb-storage 1-2:1.0
scsi 3:0:0:0: Direct-Access     ST332062 0A               0000 PQ: 0 ANSI: 0
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 3:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 27 00 00 00
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
sd 3:0:0:0: [sdb] Attached SCSI disk


usb 1-2: new high speed USB device using ehci_hcd and address 3
usb 1-2: New USB device found, idVendor=152d, idProduct=2338
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=5
usb 1-2: Product: USB to ATA/ATAPI Bridge
usb 1-2: Manufacturer: JMicron
usb 1-2: SerialNumber: D57CA3932565
scsi4 : usb-storage 1-2:1.0
scsi 4:0:0:0: Direct-Access     WDC WD50 00AAKB-00H8A0    4E05 PQ: 0 ANSI: 2 CCS
sd 4:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 4:0:0:0: Attached scsi generic sg3 type 0
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 00 38 00 00
sd 4:0:0:0: [sdb] Asking for cache data failed
sd 4:0:0:0: [sdb] Assuming drive cache: write through
sd 4:0:0:0: [sdb] Asking for cache data failed
sd 4:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 4:0:0:0: [sdb] Asking for cache data failed
sd 4:0:0:0: [sdb] Assuming drive cache: write through
sd 4:0:0:0: [sdb] Attached SCSI disk

# iBook G4 12.1" mid2005 (kernel linux-2.6.37)

usb 1-1: new high speed USB device using ehci_hcd and address 12
usb 1-1: New USB device found, idVendor=04b4, idProduct=6830
usb 1-1: New USB device strings: Mfr=0, Product=57, SerialNumber=44
usb 1-1: Product: Cypress AT2LP
usb 1-1: SerialNumber: DEF10CE2CF76
scsi12 : usb-storage 1-1:1.0
scsi 12:0:0:0: Direct-Access     ST332062 0A               0000 PQ: 0 ANSI: 0
sd 12:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 12:0:0:0: Attached scsi generic sg2 type 0
sd 12:0:0:0: [sdb] Write Protect is off
sd 12:0:0:0: [sdb] Mode Sense: 27 00 00 00
sd 12:0:0:0: [sdb] Assuming drive cache: write through
sd 12:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 12:0:0:0: [sdb] Assuming drive cache: write through
sd 12:0:0:0: [sdb] Attached SCSI disk


usb 1-1: new high speed USB device using ehci_hcd and address 11
usb 1-1: New USB device found, idVendor=152d, idProduct=2338
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=5
usb 1-1: Product: USB to ATA/ATAPI Bridge
usb 1-1: Manufacturer: JMicron
usb 1-1: SerialNumber: D57CA3932565
scsi11 : usb-storage 1-1:1.0
scsi 11:0:0:0: Direct-Access     WDC WD50 00AAKB-00H8A0    4E05 PQ: 0 ANSI: 2 CCS
sd 11:0:0:0: Attached scsi generic sg2 type 0
sd 11:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 11:0:0:0: [sdb] Write Protect is off
sd 11:0:0:0: [sdb] Mode Sense: 00 38 00 00
sd 11:0:0:0: [sdb] Assuming drive cache: write through
sd 11:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 11:0:0:0: [sdb] Assuming drive cache: write through
sd 11:0:0:0: [sdb] Attached SCSI disk




-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
