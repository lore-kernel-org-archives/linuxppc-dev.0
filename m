Return-Path: <eberhard.stoll@berghof.com>
Received: from mail117.messagelabs.com (mail117.messagelabs.com
	[195.245.231.211]) by ozlabs.org (Postfix) with SMTP id 80E07679FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 19:07:26 +1100 (EST)
Message-ID: <43F18E21.7030200@berghof.com>
Date: Tue, 14 Feb 2006 09:00:33 +0100
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: SD/MMC card driver?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I've got a mpc5200 based board with a SD card socket connected to PSC2. 
I'd like to use this SD Card as a block device, but didn't find any 
driver for SD/MMC Cards in kernel 2.4 (denx 2.4.15). So my question is:
Are there any drivers for linux & SD/MMC Cards attached to a spi 
interface (e.g. mpc5200)?

thanks in advance!
Eberhard
