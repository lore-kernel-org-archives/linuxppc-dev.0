Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id AAD9A2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 04:47:07 +1000 (EST)
Date: Mon, 11 Oct 2004 11:47:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: annamaya <annamaya@yahoo.com>
Message-ID: <20041011184705.GD6871@smtp.west.cox.net>
References: <20041011181553.GC6871@smtp.west.cox.net>
	<20041011183828.93046.qmail@web53803.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041011183828.93046.qmail@web53803.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 11, 2004 at 11:38:28AM -0700, annamaya wrote:

> Oops! Thanks for pointing that blooper. I am so used
> to dealing with the U-Boot header of 64 bytes that I
> misread the ELF header size as 64 bytes instead of 64
> KBytes. 
> 
> Anyways, it looks like I am much farther that I have
> ever been before. Now, I see that the PC is stuck at
> some address that I am not sure what to make off. Is
> this before the MMU has been turned on? Also, it looks
> like my BDI is not showing the "Debug entry cause"
> correctly.

Could you send more of the boot-log ?  And what board is this exactly on
what kernel?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
