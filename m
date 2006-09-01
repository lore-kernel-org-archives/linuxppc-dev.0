Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id B970667B72
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 23:55:00 +1000 (EST)
Subject: Re: Unable to boot kernel 2.6 from u-boot 1.1.4 in Xilinx ML403
From: Jeff Angielski <jeff@theptrgroup.com>
To: Aleck Lin <aleck@gdatech.com>
In-Reply-To: <000a01c6cd6e$5e1970a0$800101df@monstertop>
References: <000a01c6cd6e$5e1970a0$800101df@monstertop>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:49:25 -0400
Message-Id: <1157118566.7650.4.camel@sumo-jaa>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-31 at 19:28 -0700, Aleck Lin wrote:
> Hi,
> 
> I'm working on booting kernel 2.6 on Xilinx. And I'm encountering a few
> problems. 
> 
> 1. When I directly download zImage.elf to the RAM and boot from there, I see
> the kernel starts booting, but it complains about not being able to mount
> /dev/sysace/disc0/part2 and thus kernel panic happens.

Can u-boot access the systemace CF?

Do the kernel statup messages show that the system ace driver is loaded
and has successfully initialized?  I don't see this in your boot message
dump.


Jeff Angielski
The PTR Group
