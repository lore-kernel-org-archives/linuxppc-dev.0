Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id C60B1684D7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 17:14:39 +1000 (EST)
To: Robin Gilks <robin.gilks@tait.co.nz>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Oct 2005 14:17:57 +1300."
	<434B12C5.2050809@tait.co.nz>
Date: Tue, 11 Oct 2005 09:14:23 +0200
Sender: wd@denx.de
Message-Id: <20051011071423.7488A353ADC@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <434B12C5.2050809@tait.co.nz> you wrote:
> 
> struct map_info physmap_map = {
>     .name = "Physically mapped flash",
...
> Note that the name has embedded spaces - something I've never managed to 
> get U-Boot to pass across on the kernel command line (I'm sure Wolfgang 
> will correct me if I'm wrong here!!). The '1' in your 

You are 100% correct. When using command line partitioning, the .name
entry must not contain spaces (no matter which boot loader you use  -
this is a problem with the Linux kernel's argument parsing).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Quote from a recent meeting:   "We are going to continue having these
meetings everyday until I find out why no work is getting done."
