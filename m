Return-Path: <sr@denx.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id DA6E767D22
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 18:20:30 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 25 Jul 2005 10:07:55 +0200
References: <20050725071638.67632.qmail@web8503.mail.in.yahoo.com>
In-Reply-To: <20050725071638.67632.qmail@web8503.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507251007.55970.sr@denx.de>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Xilinx ML300 support in 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I am looking for Xilinx PPC4xx support (e.g. ML300) in 2.6. Please correct me 
if I am wrong, but I only found very basic Xilinx related stuff in the 
current 2.6er kernel (e.g. pic). Device drivers, especially serial, network 
and i2c don't seem to be implemented right now.

Is anybody working on porting the Xilinx PPC4xx support including the device 
drivers to 2.6 right now? Any infos or pointer are most welcome.

Best regards,
Stefan
