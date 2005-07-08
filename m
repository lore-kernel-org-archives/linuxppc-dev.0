Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6364867B92
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 12:04:46 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <354AB8A8-1BE5-4BC0-8252-D51D1CEF6B51@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 7 Jul 2005 21:04:52 -0500
To: "Bizhan Gholikhamseh \\\(bgholikh\\\)" <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: remap_page_range not resolved
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is probably due to the change of remap_page_range to  
remap_pfn_range.  I forget the exact kernel version this was changed in.

- kumar

On Jul 7, 2005, at 4:58 PM, Bizhan Gholikhamseh \\((bgholikh\\)) wrote:

> Hi All,
> I am porting a Linux PCI driver originally developed for X86  
> platform to
> MPC8540ADS reference  board by Freescale running 2.6 Linux.
> The "insmod" command fails when I am trying to load the module. The
> failure is because the reference to a function name can not be  
> resolved:
> "remap_page_range"
> Could someone help me please to find out what I am missing from my
> kernel image?
>
> Regards,
> Bizhan
>
> <ATT507020.txt>
>
