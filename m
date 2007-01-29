Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 02550DDF85
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 03:36:12 +1100 (EST)
Message-ID: <45BE2276.5010303@freescale.com>
Date: Mon, 29 Jan 2007 10:36:06 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
References: <11691560171514-git-send-email-timur@freescale.com>	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>	<45BA1952.80206@freescale.com>
	<EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>
In-Reply-To: <EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I did this as well, I'm talking about the debug options being  
> different and USB support.  (Not simple diffs handled by make  
> menuconfig).

I can't explain those.  I didn't touch the USB or debug options when I changed 
the config for the ITX-GP.  I just changed the flash configuration.  Now that I 
think about it, I should probably have disabled SATA and a few other things that 
the ITX-GP is missing.

What do you suggest I do?  Should I just try it again?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
