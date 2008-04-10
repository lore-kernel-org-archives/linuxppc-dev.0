Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACF2ADE4E4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Apr 2008 01:12:19 +1000 (EST)
Date: Thu, 10 Apr 2008 17:12:06 +0200
From: Sebastian Siewior <bigeasy@tglx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [POWER] mpc85xx_ds add DMA engine to the DT and parse
	it.
Message-ID: <20080410151206.GA21517@www.tglx.de>
References: <20080311103906.GD9656@www.tglx.de>
	<60A35F8F-FA66-4ADD-B192-6AC6A301DBA0@kernel.crashing.org>
	<20080314230130.GA6812@www.tglx.de>
	<B4CD3ECE-5F98-4A7B-A811-A84EADA804CF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <B4CD3ECE-5F98-4A7B-A811-A84EADA804CF@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2008-04-10 09:46:39 [-0500]:

>>This is a modified entry I found in the documentation for the 8544.
>>
>>Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
>>---
>>arch/powerpc/boot/dts/mpc8544ds.dts      |   41 +++++++++++++++++++++ 
>>+++++++++
>>arch/powerpc/platforms/85xx/mpc85xx_ds.c |   13 +++++++++
>>2 files changed, 54 insertions(+), 0 deletions(-)
>
>applied.
Thank you.

>I also added updating the defconfig to enable the driver by default.
I just noticed that commit 049c9d455 renamed the ids. I couldn't find
this commit in your git tree. Did you rename the ids in the .dts file
(or want me to do this)?

>- k
Sebastian
