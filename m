Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5824DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Apr 2008 02:31:45 +1100 (EST)
To: dgaur@cdotd.ernet.in
In-Reply-To: <20080405063151.M54613@cdotd.ernet.in>
Message-Id: <E1Ji9jK-0002RO-Fb@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Sat, 05 Apr 2008 07:50:54 -0700
Subject: Re: Booting Linux Kernel on MPC8560
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Deepak Gaur wrote:
> 
> I have a task to boot Mvista kernel on MPC8560 based board. The
> bootloader in U-boot.
> After decompression my final image is located at address 0x1fff0040 in
> SDRAM

That's your problem.  This code only works when loaded at address 0.
Fix your bootloader configuration.

-Dale
