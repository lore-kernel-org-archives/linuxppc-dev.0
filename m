Return-Path: <nvbolhuis@aimsys.nl>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by ozlabs.org (Postfix) with ESMTP id 4046167B8D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Oct 2006 19:14:24 +1000 (EST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id k9A95xZi020263
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Oct 2006 11:06:04 +0200 (CEST)
	(envelope-from nvbolhuis@aimsys.nl)
Message-ID: <452B626D.8050106@aimsys.nl>
Date: Tue, 10 Oct 2006 11:05:49 +0200
From: Norbert van Bolhuis <nvbolhuis@aimsys.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8xx CPM I2C interface driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Is there no MPC8xx CPM I2C interface driver in (latest) linux v2.6 or am I
mistaken ?
There's no code for CONFIG_I2C_ALGO8XX.

I've a MPC870 based board and I was hoping for a MPC8xx CPM I2C interface driver
to be there (allowing user applications to open and read/write /dev/i2c-0)

Thanks,
N.



-- 
This message has been scanned for viruses and is believed to be clean
