Return-Path: <achim.machura@berghof.com>
Received: from mail114.messagelabs.com (mail114.messagelabs.com
	[195.245.231.163]) by ozlabs.org (Postfix) with SMTP id C7D4E683A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 18:00:13 +1000 (EST)
Received: from BATEEE52 (batee-e52.be-int [10.255.241.52])
	by pegasus.berghof.com (8.12.10/8.12.10) with SMTP id j8R7rWMM032309
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Sep 2005 09:53:32 +0200
From: "Achim Machura" <achim.machura@berghof.com>
To: "'TXEMA LOPEZ'" <tlopez@aotek.es>
Date: Tue, 27 Sep 2005 09:53:25 +0200
Message-ID: <001401c5c338$8af7d5d0$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <918EB199DDDFFA42BEA2EB3A1C6021F3628924@correo.fagorautomation.net>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: Kernel debugging problem on MPC5200.
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Jose,

we have the experience(with Lauterbach - Debugger), that if the Kernel has
USB enabled, debugging craches after the kernel initializes the the
USB-controller.
If we disable USB debugging is possible, but you have to initialize the MMU.

Best regards,
Achim
