Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 460F747506
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:27:14 +1100 (EST)
Message-Id: <A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] watchdog: Basic support for GE Fanuc's FPGA based
	watchdog timer
Date: Tue, 6 Jan 2009 22:27:00 -0600
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
	<20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Martyn Welch <martyn.welch@gefanuc.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 10, 2008, at 6:31 AM, Martyn Welch wrote:

> GE Fanuc SBC610
>
> Support for the FPGA based watchdog timer as found on GE Fanuc's  
> SBC310,
> SBC610 and PPC9A Single Board Computers.
>
> This patch adds support for the watchdog timer found in one of the  
> devices
> FPGAs. There are two identical watchdog timers at different offsets  
> in the
> above mentioned boards, this driver is capable of supporting one of  
> them.
> The watchdog timers are also capable of generating interrupts at a
> user-configurable threshold, though support for this operation is  
> currently
> not supported by the driver.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> drivers/watchdog/Kconfig   |    6 +
> drivers/watchdog/Makefile  |    1
> drivers/watchdog/gef_wdt.c |  333 +++++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 340 insertions(+), 0 deletions(-)

Wim,

Any status of acceptance of this?

- k
