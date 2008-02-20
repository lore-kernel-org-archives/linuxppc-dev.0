Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id D1723DDE48
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 04:06:34 +1100 (EST)
Date: Wed, 20 Feb 2008 18:03:25 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] state of GEN_RTC vs rtc subsystem
Message-ID: <20080220180325.46446675@i1501.lan.towertech.it>
In-Reply-To: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
References: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, rz@linux-m68k.org,
	LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Feb 2008 10:11:23 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> Is the functionality provided by drivers/char/gen_rtc.c completely  
> handled by the rtc subsystem in drivers/rtc?
> 
> I ask for two reasons:
> 1. should we make it mutually exclusive in Kconfig
> 2. I've enabled both and get (we'll my defconfig did):

 They shouldn't be enabled at once. I think a patch 
 for Kconfig has been recently submitted to give a warning
 in such a case.

 rtc-cmos should be able to handle the vast majority of x86
 rtcs out there. 

 The only real open issue is related to the ntp synchronization
 mode and will be solved only when we can get rid of it :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
