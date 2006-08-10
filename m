Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id BD0CE67B79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 08:04:37 +1000 (EST)
Subject: Re: Which is better for Wireless Network Support, 2.6 or 2.4?
From: Lee Revell <rlrevell@joe-job.com>
To: wei.li4@elf.mcgill.ca
In-Reply-To: <20060810132251.ycxgkqik5csw0gc0@webmail.mcgill.ca>
References: <20060810132251.ycxgkqik5csw0gc0@webmail.mcgill.ca>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 18:04:46 -0400
Message-Id: <1155247486.20210.28.camel@mindpipe>
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

On Thu, 2006-08-10 at 13:22 -0400, wei.li4@elf.mcgill.ca wrote:
> Hi All,
> 
> I am working on wireless data application via MPC875 host USB, is there 
> any difference to use Linux 2.6.x or Linux 2.4.x? Is it Linux 2.6 more 
> like RTOS? Thanks.
> 

Yes, absolutely.  Recent Linux 2.6 kernels (since 2.6.14 or so) have
much better RT performance if PREEMPT is enabled than any 2.4 kernel.

Lee
