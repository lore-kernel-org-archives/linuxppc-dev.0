Return-Path: <Martin.Krause@tqs.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 30 Nov 2004 12:26:53 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E029E2720@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: <zhonglei@RCS-9000.COM>
Cc: Linuxppc-embedded@ozlabs.org
Subject: AW: USB driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi zhonglei

zhonglei wrotes on Dienstag, 30. November 2004 12:19:
> hi:
> My system is Lite5200 with DENX Embedded Linux running on
> it.I want to connect USB mass storage devices to my
> computer's USB port.But I found there is no driver in
> kernel.(when I use 'make xconfig' the USB mass storage
> devices driver is in grey).How can I download/install the
> driver and active my USB disk?

SCSI support has to be enabled before USB mass storage support
could be enabled. AFAIR it is saver to use make menuconfig
instead of make xconfig.

Regards,
Martin
