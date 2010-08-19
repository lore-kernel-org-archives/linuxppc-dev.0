Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 27150B70DF
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 17:56:35 +1000 (EST)
Received: by ewy2 with SMTP id 2so1209136ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 00:56:33 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Aug 2010 00:56:33 -0700
Message-ID: <AANLkTikoz2vi5Db1WLcUV-C216c9x0TY4rXQjtXsjFOp@mail.gmail.com>
Subject: mpc8xx microcode patch?
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The kernel supports three microcode patch: USB_SOF_UCODE_PATCH,
I2C_SPI_UCODE_PATCH, and I2C_SPI_SMC1_UCODE_PATCH. However from the
mpc8xxmc01.zip downloaded from freescale website, there are 4
combinations of microcode (I2C/SPI, SMC/SPI, SMC/I2C, and SMC). Also
in the EB662.pdf it's mentioned that SMC relocation patch is
applicable to all MPC8xx families and revisions. Surprisingly the SMC
only relocation patch cannot be found in the kernel. My processor is
MPC870 and I'm not sure what ucode patch I shall apply.

What am I missing here? This EB662.pdf was published in Jan. 2006.
It's hard to believe that the kernel hasn't incorporate what needs to
be done.

Thanks,
-Shawn.
