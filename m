Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 1E1842BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 04:15:55 +1000 (EST)
Date: Mon, 11 Oct 2004 11:15:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: annamaya <annamaya@yahoo.com>
Message-ID: <20041011181553.GC6871@smtp.west.cox.net>
References: <079593FC-1BA4-11D9-A165-003065F9B7DC@embeddededge.com>
	<20041011175055.93158.qmail@web53805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041011175055.93158.qmail@web53805.mail.yahoo.com>
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

On Mon, Oct 11, 2004 at 10:50:54AM -0700, annamaya wrote:

> I loaded a zImage into address 0x100000 in RAM and
> verified that this was indeed an ELF file. I then said
> "go 0x100040" which would start executing the code
> after skipping the 64 bytes of ELF header. But this is
> what I see happen. 

It's 64Kilobytes, so you'd want 0x00110000.  You also might be loading
yourself a bit too low.  The default link address is (assuming this is
2.4 and I'm still recalling right) 0x00200000, so you might as well load
things there.

-- 
Tom Rini
http://gate.crashing.org/~trini/
