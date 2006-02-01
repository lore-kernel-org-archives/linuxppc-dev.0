Return-Path: <addison.baldwin@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.193])
	by ozlabs.org (Postfix) with ESMTP id 3C56B68A02
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 04:26:05 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so133128wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Feb 2006 09:26:04 -0800 (PST)
Message-ID: <af313df20602010926o305b24b6p555843ed96bbf491@mail.gmail.com>
Date: Wed, 1 Feb 2006 17:26:04 +0000
From: Addison Baldwin <addison.baldwin@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8272ADS Hangs with gcc 4.0.0 and u-boot 1.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi developers

I have a MPC8272ADS board, from Freescale. I'm using low-boot
configuration (HRCW is 0x0E_74_B2_0A).

I have ELDK 3.1 and ELDK 4.0 installed. I'm using U-Boot 1.1.4. When I
compile U-Boot with GCC 3.3.3, the board works ok, but not with GCC
4.0.0. All the ethernet leds freeze turned on and the Run led too. It
makes me thinking the board entered some loop state. Nothing appears
at serial port.

If anyone had this problem, or if anyone have such a configuration
working (GCC 4 and U-Boot 1.1.4 with this board), any help will be
very appreciated.

Regards,
Addison Baldwin
