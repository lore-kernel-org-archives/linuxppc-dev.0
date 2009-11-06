Return-Path: <alan@nishioka.com>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id EE499B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 04:15:09 +1100 (EST)
Received: from [68.122.33.217] (helo=[192.168.1.92])
	by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <alan@nishioka.com>) id 1N6SHc-0004aU-Al
	for linuxppc-dev@lists.ozlabs.org; Fri, 06 Nov 2009 12:07:32 -0500
Message-ID: <4AF457D1.2040607@nishioka.com>
Date: Fri, 06 Nov 2009 09:07:29 -0800
From: Alan Nishioka <alan@nishioka.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: DMA to User-Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>	<4AF0E4A0.30802@windriver.com>	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>	<BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>	<4AF3BCC4.6070702@nortel.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0331031240@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0331031240@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

you can also reserve some physical memory at the top of memory and dma 
into that.
of course, this means you have to know how much memory you need before 
booting the kernel.
