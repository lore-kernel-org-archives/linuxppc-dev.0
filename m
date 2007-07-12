Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.246.247.9])
	by ozlabs.org (Postfix) with ESMTP id BF54DDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 04:49:54 +1000 (EST)
Subject: Re: XSysAce driver cant mount DOS part
From: Jeff Angielski <jeff@theptrgroup.com>
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 14:26:40 -0400
Message-Id: <1184264800.22249.17.camel@jaalaptop>
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

On Thu, 2007-07-12 at 13:03 -0500, Robertson, Joseph M. wrote:
> Hi all,
> 
> I've been workig with this for a while but have made no progress.
> Today I got the latest XSysAce patch for kernel 2.6.17.1 and applied
> it to get clean code. 
> I inherited the previous code from another developer.
> 
> My problem is that mounting the DOS partition always fails in a short
> time with a kernel oops.

Can you access that partition on your Linux host using a CF adapter?

Can you access that partition from the uboot prompt?

How did you format that partition?  mkfs.msdos?


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
