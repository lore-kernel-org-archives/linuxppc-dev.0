Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A7378DDDCA
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Nov 2008 06:42:47 +1100 (EST)
Date: Sat, 15 Nov 2008 14:42:43 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: USB problems in 2.6.28-rc*
Message-ID: <20081115144243.02ec88d0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anybody else seeing USB problems in the 2.6.28 kernels? The warp has a
USB 1.1 port off the 440EP processor. 

In 2.6.26 we had some problems with certain USB keys, but 2.6.27 fixed
it. However, the 2.6.28 stream broke it again before rc1. We get this
twice when you try to use the usb key:

sd 0:0:0:0: [sda] 990865 512-byte hardware sectors: (507 MB/483 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
sd 0:0:0:0: timing out command, waited 60s

It then seems to work. I haven't looked into it too much since we
aren't switching to 2.6.28 anytime soon (it breaks our Secure Digital
card driver).

But I am hoping somebody might know a quick fix... something like "have
you got CONFIG_x set" type answer ;)

Cheers,
   Sean
