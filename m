Return-Path: <sr@denx.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 4A58167B1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 15:16:54 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux not booting consistantly
Date: Fri, 22 Sep 2006 06:50:20 +0200
References: <20060922010445.20750.qmail@web33408.mail.mud.yahoo.com>
In-Reply-To: <20060922010445.20750.qmail@web33408.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609220650.20992.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jeff,

On Friday 22 September 2006 03:04, Jeff Stevens wrote:
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.15
>    Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
>    Data Size:    1067371 Bytes =  1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
>   Could this be a memory issue (i.e. bad memory
> configuration)?  Though, if it were a memory issue,
> wouldn't the kernel fail to uncompress successfully?

No, not necessarily. U-Boot normally hasn't D-cache enabled on 440 platforms, 
so while uncompressing the kernel no bursts are generated to the SDRAM. And 
with the bursts the "real fun" begins. ;-)

So, yes: I also think you have a memory problem.

> Does anyone have any ideas why it would work about
> once every 10 - 20 resets?

Did you try to analyze where it crashes?

http://www.denx.de/wiki/view/DULG/LinuxPostMortemAnalysis

Best regards,
Stefan
