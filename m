Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BCC2267B69
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 08:55:43 +1000 (EST)
Date: Tue, 2 May 2006 15:55:40 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: pravin <pravin3560@yahoo.com>
Subject: Re: U-boot1.1.4 porting problem on PPC 440GX
Message-ID: <20060502225540.GA25045@gate.ebshome.net>
References: <20060502223259.55214.qmail@web50512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060502223259.55214.qmail@web50512.mail.yahoo.com>
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

On Tue, May 02, 2006 at 03:32:59PM -0700, pravin wrote:
> Hi All,
>   I build uboot1.1.4 for ocotea_config  and run on an ocotea without SPD on DIMMS (SDRAM) and  It works. We manufactured another board derived from Ocotea Ref design, 440GX processor and on baord SDRAM (DIMMS) 256MB discrete parts. I use the same Uboot1.1.4 for this board. It boots upto calling the 
>    
>   relocate_code in cpu/ppc4xx/start.S and hangs. The same code works well on Ocotea. I run the memory tests and it passed all.
>    
>   Any idea why this could hang and never finish the relocate_code function. Trying relocating Uboot to SDRAM memory to get the C environment and run from memory.
>    
>   Any help would be appreciated. Any idea if i need any special code because of the discrete parts of SDRAM on our board.

You can use Ocotea code (kernel and/or U-Boot) as-is for your board 
only in one case - your board is _identical_ to Ocotea.

I doubt that this is the case, so you have to modify U-Boot and/or 
kernel board support code to accommodate any differences between Ocotea 
and your design.

Start with asking your hardware people about such differences.

-- 
Eugene
