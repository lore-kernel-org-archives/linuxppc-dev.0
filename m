Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 14CE72BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 07:44:33 +1000 (EST)
Date: Mon, 11 Oct 2004 14:44:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: annamaya <annamaya@yahoo.com>
Message-ID: <20041011214432.GB8121@smtp.west.cox.net>
References: <20041011184705.GD6871@smtp.west.cox.net>
	<20041011211859.70484.qmail@web53808.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041011211859.70484.qmail@web53808.mail.yahoo.com>
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

On Mon, Oct 11, 2004 at 02:18:59PM -0700, annamaya wrote:

> I do not have any other logs when this happens since I
> dont have any serial output when the failure happens.
> I am trying to do this on a EP8280 eval board. Has
> someone already included support for this board in the
> Kernel? Thank you.

Without knowing which kernel you're using, I can't say for certain, but
would assume it should work.  When you type 'go 0x210000' after loading
the kernel, you get nothing?

-- 
Tom Rini
http://gate.crashing.org/~trini/
