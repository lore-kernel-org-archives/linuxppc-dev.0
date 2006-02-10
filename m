Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C23FF67B78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:40:52 +1100 (EST)
Date: Fri, 10 Feb 2006 17:32:13 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: "dibacco@inwind.it" <dibacco@inwind.it>
Subject: Re: kernel startup
In-Reply-To: <IUHW4N$47B2C300D721E9A22AAA3B454F79F6F4@libero.it>
Message-ID: <Pine.LNX.4.44.0602101730210.31619-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 11 Feb 2006, dibacco@inwind.it wrote:

> Normally is it the uboot that uncompresses the kernel or the kernel uncompress itself? 

How would something compressed uncompress itself?  If u-boot is being used 
it will uncompress a compressed kernel and put the image at physical 0.

> The function called by uboot when I type boot is _start?

Are you asking about u-boot's _start or the kernel's?
 
> What does it mean that the load address is 0x00000000? 

its the address u-boot's going to jump to and start executing kernel code 
from.

- kumar
