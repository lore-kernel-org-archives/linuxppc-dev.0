Return-Path: <isidoro@qassessorament.net>
Received: from correo6.acens.priv (unknown [217.116.0.39])
	by ozlabs.org (Postfix) with ESMTP id 6ECB72BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 09:48:22 +1100 (EST)
Received: from unknown (HELO yoda) (isidoro.qassessorament.net@[213.97.58.77])
	(envelope-sender <isidoro@qassessorament.net>)
	by rb-0-39.acens.net (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 30 Nov 2004 22:39:10 -0000
From: Isidoro Reyes de Zuloaga <isidoro@qassessorament.net>
To: linuxppc-dev@ozlabs.org
Date: Tue, 30 Nov 2004 22:41:29 +0100
References: <200411301206.44403.isidoro@qassessorament.net>
In-Reply-To: <200411301206.44403.isidoro@qassessorament.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411302241.29595.isidoro@qassessorament.net>
Subject: Re: Mounting usb pendrive
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your help,=20
i recompiled the kenel with the old scsi driver and i works fine.
cheers.
isidoro
El Martes 30 Noviembre 2004 12:06, Isidoro Reyes de Zuloaga escribi=F3:
> Hi folks,
> I'm trying to mount my usb pendrive device and i'm getty a strange error
> message. I compiled my kernel with the scsi modules and all the stuff, and
> i can mount it on my x86, but in the powerbook i can't.
> this is the /var/log/messages:
>
> Nov 30 12:01:18 yoda kernel: usb 2-1.1: new full speed USB device using
> address 11
> Nov 30 12:01:18 yoda kernel: usb 2-1.1: new full speed USB device using
> address 12
> Nov 30 12:02:04 yoda kernel: ohci_hcd 0001:10:1b.1: wakeup
> Nov 30 12:02:04 yoda kernel: usb 3-1: new full speed USB device using
> address 5
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel: uba: made changed
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel: uba: device 5 capacity nsec 50 bsize 512
> Nov 30 12:02:05 yoda kernel:  /dev/ub/a:end_request: I/O error, dev uba,
> sector 0
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 0
> Nov 30 12:02:05 yoda kernel:  unable to read partition table
> Nov 30 12:02:05 yoda kernel:  /dev/ub/a:end_request: I/O error, dev uba,
> sector 2
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 4
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 6
> Nov 30 12:02:05 yoda kernel: end_request: I/O error, dev uba, sector 0
> Nov 30 12:02:05 yoda kernel:  unable to read partition table
> Nov 30 12:02:05 yoda usb.agent[4698]:      ub: already loaded
>
> I don't know what's happening, it's the same when i try to mount the ipod.
> my modules are:
> usb_storage           107772  0
> scsi_mod               69856  3 sd_mod,sg,usb_storage
> usbhid                 46592  0
> hci_usb                11104  2
> bluetooth              44100  7 rfcomm,l2cap,hci_usb
> usbcore               105204  9
> ehci_hcd,ub,ohci_hcd,usb_storage,uhci_hcd,usbhid,hci_usb
>
>
> Everything seems to be right, uh??
> Thanks for your help.
> isidoro
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
