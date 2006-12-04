Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9229E67B8F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 15:42:22 +1100 (EST)
In-Reply-To: <17779.38056.64501.458056@cargo.ozlabs.ibm.com>
References: <20061122142020.3e700bac.kim.phillips@freescale.com>
	<17779.38056.64501.458056@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E68D133-183F-4BB1-84B7-E0F8664DE24A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for FP emulation for the e300c2 core
Date: Sun, 3 Dec 2006 22:41:56 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2006, at 9:23 PM, Paul Mackerras wrote:

> Kim Phillips writes:
>
>> The e300c2 has no FPU.  Its MSR[FP] is grounded to zero.  If an  
>> attempt
>> is made to execute a floating point instruction (including  
>> floating-point
>> load, store, or move instructions), the e300c2 takes a floating-point
>> unavailable interrupt (IVOR7).
>
> Can't you just point IVOR7 at the program check handler on these cpus?

No, e300c2 is a 'classic' core not book-e.  It's effectively a 603 w/ 
o and FPU.  I'll cleanup the commit message in my git tree for you.

- k
