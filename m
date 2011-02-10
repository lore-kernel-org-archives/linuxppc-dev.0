Return-Path: <ppc.addon@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6965FB711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 09:40:20 +1100 (EST)
Received: by yxs7 with SMTP id 7so892375yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 14:40:16 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 10 Feb 2011 23:40:16 +0100
Message-ID: <AANLkTi=TywofeCbwHgRkLXyKmvHeKD9kSgy_udhQXKMy@mail.gmail.com>
Subject: Re: ydl powerstation is unable to use external usb hard disk drives
From: nello martuscielli <ppc.addon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi all,
there is the same issue here on my iBook G4 with 2.6.38-rc4 thus it
isn't an issue related to ppc64.
It's not possible to use it.

usb 1-2: new high speed USB device using ehci_hcd and address 3
usb 1-2: New USB device found, idVendor=1058, idProduct=1010
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: External HDD
usb 1-2: Manufacturer: Western Digital
usb 1-2: SerialNumber: 57442D575839304138394D31313237
scsi3 : usb-storage 1-2:1.0
scsi 3:0:0:0: Direct-Access     WD       3200BEV External 1.75 PQ: 0 ANSI: 4
sd 3:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 23 00 00 00
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
 sdb: sdb1
sd 3:0:0:0: [sdb] No Caching mode page present
sd 3:0:0:0: [sdb] Assuming drive cache: write through
sd 3:0:0:0: [sdb] Attached SCSI disk




cheers,
Nel
