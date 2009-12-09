Return-Path: <aswathi.c@gmail.com>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 2F1CDB7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 20:41:37 +1100 (EST)
Received: by gxk23 with SMTP id 23so3835796gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Dec 2009 01:41:35 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 9 Dec 2009 15:11:28 +0530
Message-ID: <2f2a209f0912090141g62bbe752j2cf5c758f74f49c@mail.gmail.com>
Subject: Problem in setting timeout from user space for MPC 83x watchdog timer
From: Aswathi C <aswathi.c@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016368324b2ac6968047a487e0c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016368324b2ac6968047a487e0c
Content-Type: text/plain; charset=UTF-8

I am using MPC 8323E processor and linux-2.6.24 kernel.
I tried to set watchdog timer from user space using ioctl with the case
WDIOC_SETTIMEOUT.
I am getting timeout value as seconds and calculating corresponding modulus
for the WDT.
After that I am setting SWTC of SWCRR and writing service sequence to SWSRR.

But SWCNR is setting back to 0xffff after service sequence written into
SWSRR, means it is not setting with configured SWTC.

Can anyone tell what is the problem?
Please suggest solution..

Regards,
Aswathi

--0016368324b2ac6968047a487e0c
Content-Type: text/html; charset=UTF-8

I am using MPC 8323E processor and linux-2.6.24 kernel.<br>I tried to set watchdog timer from user space using ioctl with the case WDIOC_SETTIMEOUT.<br>I am getting timeout value as seconds and calculating corresponding modulus for the WDT.<br>
After that I am setting SWTC of SWCRR and writing service sequence to SWSRR. <br>But SWCNR is setting back to 0xffff after service sequence written into SWSRR, means it is not setting with configured SWTC.<br><br>Can anyone tell what is the problem? <br>
Please suggest solution..<br><br>Regards,<br>Aswathi<br><br>

--0016368324b2ac6968047a487e0c--
