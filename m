Return-Path: <lagrange@fr.oleane.com>
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by ozlabs.org (Postfix) with ESMTP id F1C5667B47
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Apr 2006 18:16:59 +1000 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp4.clb.oleane.net with ESMTP id k378GpjD003883
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Apr 2006 10:16:53 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RTC/I2C on 82xx with Linux 2.6.x
Date: Fri, 7 Apr 2006 10:16:23 +0200
Message-ID: <003401c65a1b$915dac90$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000001c642bd$1dc28fa0$5201a8c0@GEG2400>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I use a Linux 2.6.x on a custom 8270 board with a RTC on the I2C bus
(rtc8564).
I want to use it as the system date :
	- Is it possible ?
	- Do I need to initialize the "ppc_md" structure in the "platform_init"
function with my own RTC functions ?
	- In that case, can I use the kernel I2C layer ?

Thanks all
Laurent
