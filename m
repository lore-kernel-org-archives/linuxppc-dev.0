Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 51D5467BF5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 00:58:15 +1100 (EST)
Message-ID: <45869C06.5020507@gersys.de>
Date: Mon, 18 Dec 2006 14:47:50 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>
	<200612131356.50092.roman.fietze@telemotive.de>
In-Reply-To: <200612131356.50092.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Roman

I'm interested in your code also though I haven't had a chance to look 
at it yet. I am also having a MPC5200 based board running Wolfgang's 
kernel 2.4.25.

Roman Fietze wrote:
 > The driver uses some modified bestcomm code, because the original
 > bestcomm code from Freescale is, ahem, not very well designed, one of
 > the reasons for the new design in the 2.6. The changes were done in
 > the code image 2. They are a more generic approach for the PSC tasks,
 > so I can more easily switch PSC's. You should easily be able to modify
 > the kernel part of the driver, to use the bestcomm code from
 > Wolfgang's 2.4.25 git kernel tree. If not, please contact me and I
 > will send you the sources of my bestcomm/ subdirectory, or anybody
 > else of course.

What I am wondering is, how many DMA tasks do you run besides Audio?
I am already using DMA for IDE and FEC so Audio would be my third DMA 
task. I remember that it used to be difficult to get more than two tasks 
running at the same time.

Would you send me or post your bestcomm sources since I'm not that 
proficient in kernel programming.

Thanks
Stefan
